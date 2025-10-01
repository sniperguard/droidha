ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install packages in a single layer to minimize image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    nano \
    ca-certificates \
    jq \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd binary based on architecture
RUN set -x && \
    TTYD_VERSION="1.7.7" && \
    ARCH="$(uname -m)" && \
    case "${ARCH}" in \
        "x86_64") TTYD_ARCH="x86_64" ;; \
        "aarch64") TTYD_ARCH="aarch64" ;; \
        "armv7l") TTYD_ARCH="armhf" ;; \
        *) echo "Unsupported architecture: ${ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL "https://github.com/tsl0922/ttyd/releases/download/${TTYD_VERSION}/ttyd.${TTYD_ARCH}" -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

# Install Droid CLI using the official installer
RUN curl -fsSL https://app.factory.ai/cli | sh

# Add droid binary to PATH
ENV PATH="/root/.local/bin:${PATH}"

# Create directory for Droid configuration and set working directory
RUN mkdir -p /config/droid-config
WORKDIR /config

# Copy startup script and modular scripts
COPY run.sh /run.sh
COPY scripts/ /opt/scripts/
RUN chmod +x /run.sh \
    && chmod +x /opt/scripts/*.sh 2>/dev/null || true

# Use exec form for better signal handling
CMD ["/run.sh"]
