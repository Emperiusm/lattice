# AI Agent Development Guide

> How AI coding agents (Claude Code CLI, Codex CLI) should work on Lattice.

## Workflow

### 1. Finding Work
```bash
gh issue list --label "ai:ready" --state open
gh issue list --milestone "v0.1.0 - Foundation" --label "ai:ready"
```

### 2. Claiming an Issue
```bash
gh issue edit <N> --add-label "ai:in-progress" --remove-label "ai:ready"
git checkout -b feat/<N>-<short-description> main
```

### 3. Understanding the Issue
Every ai:ready issue has: Context, Specification, Acceptance Criteria, Constraints, References.
Before coding: read the issue, check ADRs, check related issues, review existing code.

### 4. Implementation
- Rust: follow rustfmt defaults
- Error handling: thiserror for libs, anyhow for apps
- All pub items must have doc comments
- Every feature must have unit tests
- No unsafe without SAFETY comment

### 5. Commit Convention
```
<type>(<scope>): <description>
Refs: #<issue>
```

### 6. Opening a PR
```bash
gh pr create --title "feat(voice): description" --milestone "v0.3.0"
```
PR must: link issue, describe changes, pass CI, have tests.

## Architecture Rules (HARD CONSTRAINTS)
1. All network I/O through MeshTransport trait
2. E2EE non-negotiable
3. Cross-crate communication via traits only
4. No platform code in core crates
5. Embedded homeserver is optional
6. Async everywhere (tokio)
7. No panics in library code

## Labels Reference
| Label | Meaning |
|---|---|
| ai:ready | Fully specified, ready for implementation |
| ai:needs-spec | Needs human clarification |
| ai:in-progress | Agent working on it |
| ai:review | Completed, needs human review |
| P0-P3 | Priority levels |
| size:XS-XL | Effort estimate |
