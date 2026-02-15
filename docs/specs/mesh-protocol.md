# Mesh Transport Protocol Specification

## Transport Hierarchy
1. Internet (HTTPS) — full bandwidth
2. Wi-Fi Direct/Aware — ~250 Mbps, voice capable
3. Bluetooth LE Mesh — ~1 Mbps, text only
4. LoRa — ~50 kbps, text only, long range

## Peer Discovery
- BLE: Lattice service UUID advertisements, configurable scan interval
- Wi-Fi Aware: service publication with capabilities
- LoRa: periodic beacon broadcasts

## Message Envelope
98-byte header (fits BLE characteristic): version, msg_type, msg_id[16], src_peer[32], dst_peer[32], hop_count, max_hops, timestamp, payload_len, flags. Payload is always E2EE ciphertext.

## Routing
- Direct P2P when in range
- Epidemic routing for multi-hop: forward to all peers, increment hop_count, drop at max_hops
- Bloom filter deduplication (rotated every 10 min)

## Bandwidth Management
- BLE: ~500 byte payload, fragmentation, rate limiting
- Wi-Fi Direct: TCP/UDP sockets, full Matrix federation
- LoRa: ~200 byte max, aggressive compression, text only

## State Reconciliation
Mesh → Internet: queue flush, state merge (Matrix resolution v2), key reconciliation.
Internet → Mesh: state snapshot, embedded homeserver activation, peer notification.

## Security
- Relay nodes see headers only (E2EE payload)
- Peer hashes salted per-session
- msg_id deduplication prevents replay
- Rate limiting per-peer mitigates flooding
