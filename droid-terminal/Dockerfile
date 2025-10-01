ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install packages in a single layer to minimize image size
RUN apk add --no-cache \
    bash \
    curl \
    nano \
    ca-certificates

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
