//! Error types for lattice-core

/// Errors that can occur in Lattice core operations
#[derive(Debug, thiserror::Error)]
pub enum LatticeError {
    #[error("Matrix SDK error: {0}")]
    MatrixSdk(#[from] matrix_sdk::Error),

    #[error("Serialization error: {0}")]
    Serde(#[from] serde_json::Error),

    #[error("Room not found: {0}")]
    RoomNotFound(String),

    #[error("Not authenticated - call login() first")]
    NotAuthenticated,

    #[error("Transport error: {0}")]
    Transport(String),

    #[error("Internal error: {0}")]
    Internal(String),
}
