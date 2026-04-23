#!/bin/bash
# Spawn Claude Code for theorem proving with VS Code integration

# Configuration
PROJECT_DIR="${1:-.}"
TASK="${2:-Help with theorem proving}"

echo "Starting Claude Code for theorem proving..."
echo "Project: $PROJECT_DIR"
echo "Task: $TASK"

# Navigate to project and launch Claude Code with IDE support
cd "$PROJECT_DIR" || exit 1

# Launch with IDE flag and permissions for file editing
claude --ide "$TASK"
