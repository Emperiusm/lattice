//! Peer identification and discovery types.

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub struct PeerId(pub [u8; 32]);

impl std::fmt::Display for PeerId {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        for byte in &self.0[..8] {
            write!(f, "{byte:02x}")?;
        }
        write!(f, "...")
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PeerCapabilities {
    pub protocol_version: u8,
    pub can_relay: bool,
    pub has_internet: bool,
    pub transport_mask: u8,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PeerInfo {
    pub id: PeerId,
    pub capabilities: PeerCapabilities,
    pub signal_strength: Option<i16>,
    pub discovered_via: String,
    pub last_seen_ms: u64,
}
