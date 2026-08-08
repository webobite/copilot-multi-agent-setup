# Copilot Instructions

## Project Analysis Workflow

This repository is configured with 5 custom agents for comprehensive codebase analysis. When asked to analyze or review the project, use these agents:

1. **@architecture-planner** — Maps project structure, dependencies, design patterns
2. **@prerequisite-checker** — Validates installation, build, and runtime readiness
3. **@vulnerability-scanner** — Finds security vulnerabilities and unsafe patterns
4. **@code-standards-auditor** — Checks SOLID principles, code smells, test quality
5. **@security-validator** — Validates auth, authorization, data protection, OWASP compliance

## How to Use

### Full Analysis
Run each agent sequentially in Copilot Chat:
```
@architecture-planner analyze this project
@prerequisite-checker check all prerequisites
@vulnerability-scanner scan for vulnerabilities
@code-standards-auditor audit code quality
@security-validator validate security controls
```

### Quick Check (pick what you need)
- Architecture overview: `@architecture-planner`
- "Can I run this?": `@prerequisite-checker`
- Security audit: `@vulnerability-scanner` + `@security-validator`
- Code quality: `@code-standards-auditor`

## Code Standards

When writing or reviewing code in this project:

- Follow existing naming conventions and file organization patterns
- All new endpoints must have input validation
- All new functions must have error handling
- Security-sensitive code must be reviewed by @vulnerability-scanner before merging
- Keep functions under 50 lines and files under 500 lines
- Write tests for all new business logic
