#!/bin/bash
# Post-create script - runs once when the container is first created

set -e

echo "🦑 Setting up Atuin development environment..."

# Install Python dependencies for documentation
echo "📚 Installing documentation dependencies..."
pip install --user -e ./docs
echo "   (mkdocs-material and related plugins installed)"

# Fetch cargo dependencies and warm up the build cache
echo "📦 Fetching Rust dependencies..."
cargo fetch

# Initial build to populate the cache (optional, can take a while)
echo "🔨 Running initial cargo check..."
cargo check --workspace --all-features

echo ""
echo "✅ Atuin development environment is ready!"
echo ""
echo "Useful commands:"
echo "  cargo build              - Build the project"
echo "  cargo test               - Run unit tests"
echo "  cargo nextest run        - Run tests with nextest (CI style)"
echo "  cargo clippy             - Run linter"
echo "  cargo fmt                - Format code"
echo "  cargo deny check         - Check dependencies for issues"
echo "  cd docs && mkdocs serve  - Serve documentation locally"
echo "  codespell                - Check spelling"
echo "  shellcheck *.sh          - Check shell scripts"
echo ""
echo "For integration tests (require PostgreSQL):"
echo "  docker run -d --name postgres -e POSTGRES_USER=atuin -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=atuin -p 5432:5432 postgres:16"
echo "  ATUIN_DB_URI=postgres://atuin:pass@localhost:5432/atuin cargo nextest run --test '*'"
echo ""
