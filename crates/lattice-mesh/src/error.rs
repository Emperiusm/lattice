//! Error types for lattice-mesh

#[derive(Debug, thiserror::Error)]
pub enum MeshError {
    #[error("Transport '{0}' is not active")]
    TransportNotActive(String),
    #[error("Peer not reachable: {0}")]
    PeerNotReachable(String),
    #[error("Payload too large ({actual} bytes, limit {limit})")]
    PayloadTooLarge { actual: usize, limit: usize },
    #[error("I/O error: {0}")]
    Io(#[from] std::io::Error),
    #[error("Serialization error: {0}")]
    Serde(#[from] serde_json::Error),
    #[error("Broadcast not supported by '{0}'")]
    BroadcastNotSupported(String),
    #[error("Transport stopped")]
    Stopped,
    #[error("Platform error: {0}")]
    Platform(String),
    #[error("Hop limit exceeded ({0})")]
    HopLimitExceeded(u8),
    #[error("Duplicate message: {0}")]
    DuplicateMessage(String),
}
