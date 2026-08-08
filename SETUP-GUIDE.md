# Multi-Agent Copilot Setup — Installation Guide

Drop this `.github/` folder into any repo and get 5 specialized AI agents in VS Code.

---

## What's Inside

```
.github/
├── agents/
│   ├── architecture-planner.agent.md    → Maps structure, deps, patterns
│   ├── prerequisite-checker.agent.md    → Validates install/build/run readiness
│   ├── vulnerability-scanner.agent.md   → Finds security vulnerabilities
│   ├── code-standards-auditor.agent.md  → SOLID, smells, test quality
│   └── security-validator.agent.md      → Auth, OWASP, data protection
├── instructions/
│   └── security-review.instructions.md  → Auto-applies security rules to all code files
└── copilot-instructions.md              → Repo-level Copilot context
```

## Installation (2 minutes)

### Step 1: Copy the `.github` folder

Copy the entire `.github/` folder from this package into your repository root:

```bash
# From your repo root
cp -r /path/to/copilot-multi-agent-setup/.github .
```

If you already have a `.github/` folder (you probably do — workflows, etc.), just merge:

```bash
cp -r /path/to/copilot-multi-agent-setup/.github/agents .github/
cp -r /path/to/copilot-multi-agent-setup/.github/instructions .github/
cp /path/to/copilot-multi-agent-setup/.github/copilot-instructions.md .github/
```

### Step 2: Commit

```bash
git add .github/agents .github/instructions .github/copilot-instructions.md
git commit -m "feat: add multi-agent Copilot setup for codebase analysis"
```

### Step 3: Open in VS Code

1. Open the repo in VS Code
2. Open Copilot Chat (Ctrl+Alt+I / ⌃⌘I)
3. Switch to **Agent** mode (dropdown at top of chat)
4. The custom agents are now available via `@` mentions

## Usage

### Invoke Individual Agents

In Copilot Chat (Agent mode), type:

```
@architecture-planner analyze this project
```

```
@prerequisite-checker can a new dev run this in 15 minutes?
```

```
@vulnerability-scanner scan for security vulnerabilities
```

```
@code-standards-auditor audit code quality and give me a score
```

```
@security-validator validate OWASP compliance
```

### Run All 5 for a Full Analysis

Run them one at a time. Each produces a structured report:

```
@architecture-planner analyze this project and save the report
@prerequisite-checker check all prerequisites
@vulnerability-scanner do a full vulnerability scan
@code-standards-auditor full quality audit
@security-validator complete security validation with OWASP matrix
```

### Use During Code Review

When reviewing a PR or diff:

```
@vulnerability-scanner review these changes for security issues
@code-standards-auditor check this PR for code quality
```

### Auto-Applied Rules

The `security-review.instructions.md` file automatically applies security rules whenever Copilot works with `.ts`, `.tsx`, `.js`, `.jsx`, `.py`, `.go`, `.rs`, `.java`, or `.kt` files. No action needed — it's always on.

## Customization

### Add Your Own Standards

Edit any `.agent.md` file to add project-specific rules. For example, in `code-standards-auditor.agent.md`:

```markdown
## Project-Specific Standards
- All React components must use TypeScript strict mode
- All API endpoints must use zod validation
- Database queries must go through the repository layer
```

### Add More Agents

Create a new file in `.github/agents/`:

```markdown
---
name: "My Custom Agent"
description: "What it does and when to use it"
tools:
  - codebase
  - search
---

# My Custom Agent

[Instructions here...]
```

### Connect MCP Servers

For additional tool access, add `.vscode/mcp.json`:

```json
{
  "servers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${env:GITHUB_TOKEN}"
      }
    }
  }
}
```

## Works With

- **GitHub Copilot** in VS Code (Agent mode) — primary target
- **GitHub Copilot Cloud Agent** — agents also work on github.com
- **Copilot CLI** — agents available via `gh copilot`
- **Other IDEs** — JetBrains, Eclipse, Xcode (with Copilot extension)

## FAQ

**Q: Do I need GitHub Copilot Business/Enterprise?**
A: Custom agents work on all Copilot tiers as of 2026. Some advanced features (cloud agent, parallel runs) may require Business+.

**Q: Can I use these with Claude or other models?**
A: The `.agent.md` format is GitHub Copilot-specific. For Claude Code, use the `repo-copilot` skill (already installed in your Cowork setup). For a model-agnostic approach, the instructions can be adapted to `CLAUDE.md` or `GEMINI.md` formats.

**Q: How do I run all agents in parallel?**
A: In VS Code, open multiple Copilot Chat panels (split the chat view) and invoke a different agent in each. Or use GitHub Copilot Cloud Agent which handles parallelism natively.

**Q: Will this slow down my normal Copilot completions?**
A: No. The agents only activate when you explicitly `@mention` them. They don't affect inline completions.
