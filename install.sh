#!/bin/bash
# Install multi-agent Copilot setup into any repo
# Usage: ./install.sh /path/to/your/repo

set -e

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$TARGET" ]; then
  echo "Error: $TARGET is not a directory"
  exit 1
fi

# Create directories
mkdir -p "$TARGET/.github/agents"
mkdir -p "$TARGET/.github/instructions"

# Copy agent files
cp "$SCRIPT_DIR/.github/agents/"*.agent.md "$TARGET/.github/agents/"
cp "$SCRIPT_DIR/.github/instructions/"*.instructions.md "$TARGET/.github/instructions/"

# Copy copilot instructions (don't overwrite if exists)
if [ -f "$TARGET/.github/copilot-instructions.md" ]; then
  echo "⚠ .github/copilot-instructions.md already exists — saved new version as copilot-instructions.new.md"
  cp "$SCRIPT_DIR/.github/copilot-instructions.md" "$TARGET/.github/copilot-instructions.new.md"
else
  cp "$SCRIPT_DIR/.github/copilot-instructions.md" "$TARGET/.github/"
fi

# Add safety entries to .gitignore (skip if already present)
GITIGNORE="$TARGET/.gitignore"
ENTRIES=(
  "# Copilot multi-agent setup (local only, not committed)"
  ".github/agents/"
  ".github/instructions/"
  ".github/copilot-instructions.md"
  ".github/copilot-instructions.new.md"
  ""
  "# Copilot agent reports (generated, don't commit)"
  "docs/code-review/"
  "docs/architecture/ADR-*"
  "*-review.md"
  ""
  "# Environment & secrets"
  ".env"
  ".env.local"
  ".env.*.local"
)

touch "$GITIGNORE"
for entry in "${ENTRIES[@]}"; do
  if [ -z "$entry" ]; then
    continue
  fi
  if ! grep -qxF "$entry" "$GITIGNORE" 2>/dev/null; then
    echo "$entry" >> "$GITIGNORE"
  fi
done

echo "✓ Installed 5 agents into $TARGET/.github/agents/"
echo "✓ Installed security instructions into $TARGET/.github/instructions/"
echo "✓ Updated .gitignore with safety entries"
echo ""
echo "Agents available in VS Code Copilot Chat (Agent mode):"
echo "  @architecture-planner    — project structure & patterns"
echo "  @prerequisite-checker    — install/build readiness"
echo "  @vulnerability-scanner   — security vulnerabilities"
echo "  @code-standards-auditor  — code quality & SOLID"
echo "  @security-validator      — auth, OWASP compliance"
