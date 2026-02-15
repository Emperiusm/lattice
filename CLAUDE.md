# CLAUDE.md — Lattice Project Intelligence

> This file is automatically read by Claude Code CLI when working on this project.

## Project Overview

Lattice is a Discord-class communication platform built on the Matrix protocol with mesh networking for censorship resistance. AI-first development: AI agents (Claude Code, Codex) are the primary implementers.

## Quick Reference

- **Language:** Rust (workspace with 10 crates)
- **Matrix SDK:** matrix-rust-sdk
- **Async runtime:** tokio
- **Error handling:** thiserror (libraries), anyhow (applications)
- **Logging:** tracing
- **CI:** GitHub Actions (check, fmt, clippy, test, doc, unwrap-check)

## Working on Issues

```bash
gh issue list --label "ai:ready" --state open
gh issue edit <N> --add-label "ai:in-progress" --remove-label "ai:ready"
git checkout -b feat/<N>-<short-description> main
# implement...
gh pr create --title "feat(scope): description" --body "Closes #<N>"
gh issue edit <N> --add-label "ai:review" --remove-label "ai:in-progress"
```

## Architecture Rules (NEVER VIOLATE)

1. All network I/O goes through the MeshTransport trait
2. E2EE is non-negotiable — never log/store/transmit plaintext content
3. Crate boundaries are APIs — cross-crate communication via traits only
4. No platform-specific code in core crates
5. Embedded homeserver is optional — client must work without it
6. Async everywhere — tokio, no blocking I/O
7. No panics in library code — Result<T, E> for all fallible operations

## Code Style

- `cargo fmt` before every commit
- `cargo clippy -- -D warnings` must pass
- No `unwrap()` in library crates
- No `println!()` in library crates (use tracing)
- All `pub` items must have doc comments
- Test naming: `test_<function>_<scenario>_<expected>`

## Commit Convention

```
<type>(<scope>): <description>
Refs: #<issue-number>
```

Types: feat, fix, refactor, docs, test, ci, chore
Scopes: core, mesh, mesh-ble, mesh-wifi, mesh-lora, dtn, voice, moderation, homeserver, cli, desktop

## Crate Map

| Crate | Purpose |
|---|---|
| lattice-core | Matrix SDK wrapper |
| lattice-mesh | Transport abstraction (MeshTransport trait) |
| lattice-mesh-ble | BLE backend |
| lattice-mesh-wifi | Wi-Fi Direct backend |
| lattice-mesh-lora | LoRa backend |
| lattice-dtn | Delay-tolerant networking |
| lattice-voice | Voice/video/streaming |
| lattice-moderation | Moderation tools |
| lattice-homeserver | Embedded Conduit |
| lattice-cli | TUI client |

## Key Docs

- docs/architecture/overview.md
- docs/specs/mesh-protocol.md
- docs/specs/voice-channels.md
- docs/specs/custom-emoji.md
- docs/ai-development/AGENT_GUIDE.md
- docs/ai-development/CONVENTIONS.md
- docs/architecture/adr/

## Approved Dependencies

tokio, async-trait, futures, serde, serde_json, thiserror, anyhow, tracing, tracing-subscriber, matrix-sdk, btleplug, ratatui, crossterm, rand
