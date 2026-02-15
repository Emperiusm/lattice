# ADR-001: Rust as Core Language with matrix-rust-sdk

## Status: Accepted

## Context
Lattice needs a cross-platform core language for Matrix protocol, encryption, mesh networking, and embedded homeserver.

## Decision
Use Rust with matrix-rust-sdk as the foundation.

## Consequences
### Positive
- matrix-rust-sdk is the most actively maintained Matrix SDK
- Memory safety eliminates security vulnerability classes
- Excellent cross-compilation and FFI (uniffi for mobile)
- Conduit (embedded homeserver) is also Rust
- tokio provides battle-tested async runtime
- Strong BLE/networking crate ecosystem

### Negative
- Steeper learning curve (mitigated: AI agents handle most coding)
- Longer compile times
- Mobile FFI adds complexity

## Alternatives Considered
- **Go**: weaker FFI, no matrix-rust-sdk equivalent, GC pauses for real-time audio
- **TypeScript**: not suitable for embedded homeserver/BLE/mesh
- **Kotlin Multiplatform**: weak for systems-level mesh networking
