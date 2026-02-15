# CODEX.md — Lattice Project Instructions for Codex CLI

## Project
Lattice: Discord-class Matrix client with mesh networking. Rust workspace, 10 crates.

## Setup
```bash
cargo build --workspace
cargo test --workspace
cargo clippy --workspace -- -D warnings
```

## Workflow
1. `gh issue list --label "ai:ready"` — find work
2. `git checkout -b feat/<issue-num>-<desc> main` — branch
3. Implement per issue spec
4. `cargo fmt && cargo clippy && cargo test` — validate
5. `gh pr create` — submit

## Rules
- No unwrap() in crates/*/src (use Result)
- No println!() in crates/*/src (use tracing)
- All pub items need doc comments
- tokio for all async, no std::thread
- thiserror for lib errors, anyhow for bin errors
- All network goes through MeshTransport trait
- Never handle plaintext message content (E2EE)

## See Also
- CLAUDE.md, docs/ai-development/AGENT_GUIDE.md, docs/architecture/overview.md
