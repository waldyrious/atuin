# Atuin Development Container
# Based on the official Rust devcontainer with additional tools for CI parity

FROM mcr.microsoft.com/devcontainers/rust:1-1.91-bookworm

# Install system dependencies needed for building atuin and running CI checks
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
        # Build essentials (matches CI and Dockerfile)
        build-essential \
        pkg-config \
        libssl-dev \
        # PostgreSQL client (for integration tests)
        postgresql-client \
        # protobuf compiler (for atuin-daemon gRPC)
        protobuf-compiler \
        # Shell script linting (matches shellcheck.yml workflow)
        shellcheck \
        # Spell checking (matches codespell.yml workflow)
        codespell \
        # Additional useful tools
        git-lfs \
        jq \
        curl \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install additional Rust tooling used in CI
RUN rustup component add clippy rustfmt \
    && cargo install cargo-nextest cargo-deny cargo-watch

# Set up cargo environment
ENV CARGO_TERM_COLOR=always

# Default working directory
WORKDIR /workspaces/atuin
