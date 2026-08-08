---
applyTo: "**/*.{ts,tsx,js,jsx,py,go,rs,java,kt}"
---

# Security Review Instructions

When reviewing or writing code in these file types, always check:

1. **No hardcoded secrets** — API keys, passwords, tokens must come from environment variables
2. **No SQL injection** — use parameterized queries, never string interpolation
3. **No command injection** — sanitize any input passed to shell commands
4. **No XSS** — escape all user input rendered in HTML
5. **Input validation** — validate type, length, and format of all external inputs
6. **Error handling** — never expose stack traces or internal errors to users
7. **Auth checks** — every endpoint accessing user data must verify ownership
