# Lattice Architecture Overview

## Design Principles
1. Matrix-native — build on the protocol, extend via MSCs
2. Encryption-first — all content E2EE, mesh sees only ciphertext
3. Transport-agnostic — app layer doesn't know HTTPS vs BLE vs LoRa
4. Local-first — works offline with embedded homeserver
5. Graceful degradation — fewer features on worse connections
6. Modular crates — clean API boundaries

## Components

### lattice-core
Wraps matrix-rust-sdk: session management, room management, sliding sync, event handling, crypto.

### lattice-voice
MatrixRTC voice/video: persistent voice channels (m.lattice.voice_channel state event), push-to-talk, screen streaming. Voice channels differ from calls: they persist when empty, users join/leave freely.

### lattice-moderation
Discord-class moderation mapped to Matrix: named roles with power levels, Mjolnir/Draupnir ban lists, structured audit log events, auto-moderation filters.

### lattice-mesh
Transport abstraction with MeshTransport trait. Backends: InternetTransport, BleTransport, WifiDirectTransport, LoRaTransport. TransportManager selects best available.

### lattice-dtn
Delay-tolerant networking: message queue, store-and-forward relay, epidemic routing, Bloom filter deduplication, state reconciliation when internet returns.

### lattice-homeserver
Embedded Conduit (Rust). Activates when internet drops. Handles local room state, event storage, local sync. Federation transactions queued for DTN.

### Clients
- Desktop: Tauri + web frontend
- Mobile: Flutter or native with Rust core via uniffi
- CLI: ratatui TUI for development/testing

## Custom Matrix Events
- m.lattice.voice_channel — voice channel config
- m.lattice.presence.activity — rich presence
- m.lattice.role — role definitions
- m.lattice.audit_log — moderation actions
- m.lattice.emoji_pack — custom emoji
- m.lattice.mesh.peer — mesh peer advertisement

## Security Model
Mesh threat model assumes adversarial relay nodes (E2EE), traffic analysis (future: chaff traffic), device seizure (encrypted storage, panic wipe). Matrix Megolm encryption works per-room; keys shared via Olm over mesh; relay nodes see only ciphertext.
