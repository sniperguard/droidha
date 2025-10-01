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
    local factory_source_dir="/root/.factory"
    local factory_target_dir="$data_home/.factory"

    bashio::log.info "Initializing Droid CLI environment in /data..."

    # Create all required directories
    if ! mkdir -p "$data_home" "$config_dir/droid" "$cache_dir" "$state_dir" "/data/.local"; then
        bashio::log.error "Failed to create directories in /data"
        exit 1
    fi

    # Set permissions
    chmod 755 "$data_home" "$config_dir" "$cache_dir" "$state_dir" "$droid_config_dir"
    
    # Clean up any stale lock files that might prevent droid from starting
    rm -f /data/.config/droid/*.lock 2>/dev/null || true
    rm -f /data/.local/state/droid/*.lock 2>/dev/null || true

    # Ensure Factory CLI assets are accessible from the new HOME
    if [ ! -e "$factory_target_dir" ]; then
        if [ -d "$factory_source_dir" ]; then
            ln -s "$factory_source_dir" "$factory_target_dir"
        else
            mkdir -p "$factory_target_dir"
        fi
    fi

    # Set XDG and application environment variables
    export HOME="$data_home"
    export XDG_CONFIG_HOME="$config_dir"
    export XDG_CACHE_HOME="$cache_dir"
    export XDG_STATE_HOME="$state_dir"
    export XDG_DATA_HOME="/data/.local/share"
    
    # Droid-specific environment variables
    export DROID_CONFIG_DIR="$droid_config_dir"
    export DROID_HOME="/data"
    export FACTORY_HOME="$factory_target_dir"
    
    # Add droid binary to PATH
    export PATH="/root/.local/bin:$PATH"
    export PATH="/root/.factory/bin:$PATH"

    # Prevent droid CLI from launching unavailable desktop browsers
    export BROWSER="/bin/echo"

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

print_auto_launch_script() {
    cat <<'EOF'
export PATH=/root/.local/bin:$PATH
export PATH=/root/.factory/bin:$PATH
cd /config
[ -d .git ] || (git init && git config user.name 'Home Assistant' && git config user.email 'addon@homeassistant.local')
clear
echo 'Welcome to Droid Terminal!'
echo ''

ensure_factory_auth() {
    if [ -n "${FACTORY_API_KEY:-}" ]; then
        echo 'FACTORY_API_KEY detected. Using API key authentication.'
        return 0
    fi

    local status_output raw_status
    status_output="$(droid headless status 2>&1)"
    raw_status="$(printf '%s\n' "$status_output" | sed 's/\x1b\[[0-9;]*m//g')"

    printf '%s\n' "$status_output"

    if echo "$raw_status" | grep -qi 'Not authenticated'; then
        echo ''
        echo 'No active Factory authentication detected.'
        echo 'Starting headless login flow...'
        echo ''

        if ! droid headless login; then
            echo ''
            echo 'Headless login did not complete successfully.'
            echo 'You can rerun `droid headless login` from this shell at any time.'
            return 1
        fi

        echo ''
        echo 'Authentication completed successfully.'
    fi

    return 0
}

ensure_factory_auth

echo ''
echo 'Starting Droid...'
sleep 1
droid
exit_code=$?
if [ "$exit_code" -ne 0 ]; then
    echo ''
    echo "Droid exited with code $exit_code."
else
    echo ''
    echo 'Droid exited successfully.'
fi
echo ''
echo 'Opening interactive shell...'
exec bash
EOF
}

# Determine Droid launch command based on configuration
get_droid_launch_command() {
    local auto_launch_droid

    auto_launch_droid=$(bashio::config 'auto_launch_droid' 'true')

    if [ "$auto_launch_droid" = "true" ]; then
        print_auto_launch_script
    else
        if [ -f /usr/local/bin/droid-session-picker ]; then
            echo "clear && /usr/local/bin/droid-session-picker"
        else
            bashio::log.warning "Session picker not found, falling back to auto-launch"
            print_auto_launch_script
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
