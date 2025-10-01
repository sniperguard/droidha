#!/usr/bin/with-contenv bashio

# Enable strict error handling
set -e
set -o pipefail

# Initialize environment for Droid CLI using /data (HA best practice)
init_environment() {
    # Use /data exclusively - guaranteed writable by HA Supervisor
    local data_home="/data/home"
    local config_dir="/data/.config"
    local cache_dir="/data/.cache"
    local state_dir="/data/.local/state"
    local droid_config_dir="/data/.config/droid"

    bashio::log.info "Initializing Droid CLI environment in /data..."

    # Create all required directories
    if ! mkdir -p "$data_home" "$config_dir/droid" "$cache_dir" "$state_dir" "/data/.local"; then
        bashio::log.error "Failed to create directories in /data"
        exit 1
    fi

    # Set permissions
    chmod 755 "$data_home" "$config_dir" "$cache_dir" "$state_dir" "$droid_config_dir"

    # Set XDG and application environment variables
    export HOME="$data_home"
    export XDG_CONFIG_HOME="$config_dir"
    export XDG_CACHE_HOME="$cache_dir"
    export XDG_STATE_HOME="$state_dir"
    export XDG_DATA_HOME="/data/.local/share"
    
    # Droid-specific environment variables
    export DROID_CONFIG_DIR="$droid_config_dir"
    export DROID_HOME="/data"
    
    # Add droid binary to PATH
    export PATH="/root/.local/bin:$PATH"

    # Migrate any existing authentication files from legacy locations
    migrate_legacy_auth_files "$droid_config_dir"

    bashio::log.info "Environment initialized:"
    bashio::log.info "  - Home: $HOME"
    bashio::log.info "  - Config: $XDG_CONFIG_HOME" 
    bashio::log.info "  - Droid config: $DROID_CONFIG_DIR"
    bashio::log.info "  - Cache: $XDG_CACHE_HOME"
}

# One-time migration of existing authentication files
migrate_legacy_auth_files() {
    local target_dir="$1"
    local migrated=false

    bashio::log.info "Checking for existing authentication files to migrate..."

    # Check common legacy locations
    local legacy_locations=(
        "/root/.config/droid"
        "/root/.droid" 
        "/config/droid-config"
        "/tmp/droid-config"
    )

    for legacy_path in "${legacy_locations[@]}"; do
        if [ -d "$legacy_path" ] && [ "$(ls -A "$legacy_path" 2>/dev/null)" ]; then
            bashio::log.info "Migrating auth files from: $legacy_path"
            
            # Copy files to new location
            if cp -r "$legacy_path"/* "$target_dir/" 2>/dev/null; then
                # Set proper permissions
                find "$target_dir" -type f -exec chmod 600 {} \;
                
                # Create compatibility symlink if this is a standard location
                if [[ "$legacy_path" == "/root/.config/droid" ]] || [[ "$legacy_path" == "/root/.droid" ]]; then
                    rm -rf "$legacy_path"
                    ln -sf "$target_dir" "$legacy_path"
                    bashio::log.info "Created compatibility symlink: $legacy_path -> $target_dir"
                fi
                
                migrated=true
                bashio::log.info "Migration completed from: $legacy_path"
            else
                bashio::log.warning "Failed to migrate from: $legacy_path"
            fi
        fi
    done

    if [ "$migrated" = false ]; then
        bashio::log.info "No existing authentication files found to migrate"
    fi
}

# Verify required tools are available
verify_tools() {
    bashio::log.info "Verifying required tools..."
    
    local missing_tools=()
    
    if ! command -v ttyd &> /dev/null; then
        missing_tools+=("ttyd")
    fi
    
    if ! command -v jq &> /dev/null; then
        missing_tools+=("jq")
    fi
    
    if ! command -v curl &> /dev/null; then
        missing_tools+=("curl")
    fi
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        bashio::log.error "Missing required tools: ${missing_tools[*]}"
        exit 1
    fi
    
    bashio::log.info "All required tools are available"
}

# Setup session picker script
setup_session_picker() {
    # Copy session picker script from built-in location if it exists
    if [ -f "/opt/scripts/droid-session-picker.sh" ]; then
        if ! cp /opt/scripts/droid-session-picker.sh /usr/local/bin/droid-session-picker; then
            bashio::log.error "Failed to copy droid-session-picker script"
            exit 1
        fi
        chmod +x /usr/local/bin/droid-session-picker
        bashio::log.info "Session picker script installed successfully"
    else
        bashio::log.info "Session picker script not found, using auto-launch mode only"
    fi

    # Setup authentication helper if it exists
    if [ -f "/opt/scripts/droid-auth-helper.sh" ]; then
        chmod +x /opt/scripts/droid-auth-helper.sh
        bashio::log.info "Authentication helper script ready"
    fi
}

# Determine Droid launch command based on configuration
get_droid_launch_command() {
    local auto_launch_droid
    
    # Get configuration value, default to true for backward compatibility
    auto_launch_droid=$(bashio::config 'auto_launch_droid' 'true')
    
    if [ "$auto_launch_droid" = "true" ]; then
        # Original behavior: auto-launch Droid directly
        # Set PATH and change to config directory before launching
        echo "export PATH=/root/.local/bin:\$PATH && cd /config && clear && echo 'Welcome to Droid Terminal!' && echo '' && echo 'Starting Droid...' && sleep 1 && droid 2>&1 || (echo 'Droid failed to start. Error code: \$?' && echo 'Press Enter to start a bash shell...' && read && /bin/bash)"
    else
        # New behavior: show interactive session picker
        if [ -f /usr/local/bin/droid-session-picker ]; then
            echo "clear && /usr/local/bin/droid-session-picker"
        else
            # Fallback if session picker is missing
            bashio::log.warning "Session picker not found, falling back to auto-launch"
            echo "clear && echo 'Welcome to Droid Terminal!' && echo '' && echo 'Starting Droid...' && sleep 1 && droid"
        fi
    fi
}

# Start main web terminal
start_web_terminal() {
    local port=7682
    bashio::log.info "Starting web terminal on port ${port}..."
    
    # Log environment information for debugging
    bashio::log.info "Environment variables:"
    bashio::log.info "DROID_CONFIG_DIR=${DROID_CONFIG_DIR}"
    bashio::log.info "HOME=${HOME}"

    # Get the appropriate launch command based on configuration
    local launch_command
    launch_command=$(get_droid_launch_command)
    
    # Log the configuration being used
    local auto_launch_droid
    auto_launch_droid=$(bashio::config 'auto_launch_droid' 'true')
    bashio::log.info "Auto-launch Droid: ${auto_launch_droid}"
    
    # Run ttyd with improved configuration
    exec ttyd \
        --port "${port}" \
        --interface 0.0.0.0 \
        --writable \
        bash -c "$launch_command"
}

# Run health check
run_health_check() {
    if [ -f "/opt/scripts/health-check.sh" ]; then
        bashio::log.info "Running system health check..."
        chmod +x /opt/scripts/health-check.sh
        /opt/scripts/health-check.sh || bashio::log.warning "Some health checks failed but continuing..."
    fi
}

# Main execution
main() {
    bashio::log.info "Initializing Droid Terminal add-on..."

    # Run diagnostics first
    run_health_check

    init_environment
    verify_tools
    setup_session_picker
    start_web_terminal
}

# Execute main function
main "$@"
