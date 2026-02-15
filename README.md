# Lattice

**A Discord-class communication platform built on the Matrix protocol with mesh networking resilience.**

Lattice combines Discord's rich social features (voice channels, custom emoji, game streaming, hierarchical moderation) with Matrix's open, federated, E2EE protocol — plus mesh networking that keeps communication alive when the internet goes down.

## Architecture

```
┌──────────────────────────────────────────────┐
│              Lattice Client UI                │
│         (Desktop / Mobile / CLI)              │
├──────────────────────────────────────────────┤
│              lattice-core                     │
│     (matrix-rust-sdk wrapper, core types)     │
├────────────┬─────────────┬───────────────────┤
│ lattice-   │ lattice-    │ lattice-           │
│ voice      │ moderation  │ homeserver         │
├────────────┴─────────────┴───────────────────┤
│            Transport Layer                    │
├──────────┬───────────────────────────────────┤
│ Internet │       lattice-mesh                 │
│ (HTTPS)  │  ┌─────────┬──────────┬────────┐  │
│          │  │   BLE   │ Wi-Fi    │  LoRa  │  │
│          │  │  Mesh   │ Direct   │        │  │
│          │  └─────────┴──────────┴────────┘  │
├──────────┴───────────────────────────────────┤
│              lattice-dtn                      │
│   (Store-and-Forward / State Reconciliation)  │
└──────────────────────────────────────────────┘
```

## AI-First Development

> **This project is built by AI agents, overseen by humans.**

- **Issues are specs** — every Issue has complete, machine-readable specifications
- **AI agents implement** — Claude Code / Codex pick up `ai:ready` issues, branch, code, and PR
- **Humans review and steer** — maintainers review PRs and write specs
- **CI validates** — automated tests, lints, and checks

See [CLAUDE.md](CLAUDE.md) and [docs/ai-development/AGENT_GUIDE.md](docs/ai-development/AGENT_GUIDE.md).

## Roadmap

| Phase | Milestone | Description |
|---|---|---|
| 1 | v0.1.0 | Foundation — matrix-rust-sdk integration, basic client |
| 1 | v0.2.0 | Text Messaging — rooms, spaces, threads, reactions |
| 1 | v0.3.0 | Voice & Video — MatrixRTC, voice channels, PTT |
| 1 | v0.4.0 | Discord Features — custom emoji, presence, streaming |
| 1 | v0.5.0 | Moderation Suite — roles, ban lists, audit logs |
| 2 | v0.6.0 | Embedded Homeserver — Conduit, local-first |
| 3 | v0.7.0 | Mesh Transport — BLE, Wi-Fi Direct |
| 3 | v0.8.0 | DTN & Sync — store-and-forward, reconciliation |
| 4 | v0.9.0 | Mesh Advanced — LoRa, mesh voice |
| — | v1.0.0 | Production Release |

## Tech Stack

- **Core:** Rust with matrix-rust-sdk
- **Embedded Homeserver:** Conduit (Rust)
- **Voice/Video:** MatrixRTC + WebRTC
- **Desktop:** Tauri + React/Solid
- **Mesh:** Custom Rust transport layer (BLE/Wi-Fi Direct/LoRa)

## Building

```bash
cargo build --workspace
cargo run -p lattice-cli
cargo test --workspace
```

## License

Dual-licensed: **AGPL-3.0** (open source) + **Commercial License**. See [LICENSE.md](LICENSE.md).
