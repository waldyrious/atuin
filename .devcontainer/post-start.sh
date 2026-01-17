#!/bin/bash
# Post-start script - runs every time the container starts

set -e

# Ensure git is configured for the workspace
git config --global --add safe.directory /workspaces/atuin

# Display helpful information
echo ""
echo "🦑 Welcome to the Atuin development container!"
echo ""
echo "Quick reference:"
echo "  Build:       cargo build --release"
echo "  Test:        cargo nextest run"
echo "  Lint:        cargo clippy -- -D warnings -D clippy::redundant_clone"
echo "  Format:      cargo fmt --check"
echo "  Docs:        cd docs && mkdocs serve"
echo "  Spell check: codespell"
echo ""
