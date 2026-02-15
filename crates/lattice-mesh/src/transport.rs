//! Transport trait and capabilities for mesh networking backends.

use async_trait::async_trait;
use crate::message::MeshMessage;
use crate::peer::{PeerId, PeerInfo};
use crate::Result;

#[derive(Debug, Clone)]
pub struct TransportCapabilities {
    pub max_bandwidth_bps: u64,
    pub typical_range_meters: u32,
    pub supports_broadcast: bool,
    pub supports_voice: bool,
    pub supports_background: bool,
    pub priority: u8,
}

#[async_trait]
pub trait MeshTransport: Send + Sync {
    fn name(&self) -> &str;
    fn capabilities(&self) -> &TransportCapabilities;
    async fn start(&self) -> Result<()>;
    async fn stop(&self) -> Result<()>;
    fn is_active(&self) -> bool;
    async fn discover_peers(&self) -> Result<Vec<PeerInfo>>;
    async fn send(&self, peer: &PeerId, message: &MeshMessage) -> Result<()>;
    async fn broadcast(&self, message: &MeshMessage) -> Result<()>;
    async fn recv(&self) -> Result<(PeerId, MeshMessage)>;
}
