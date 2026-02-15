//! # lattice-mesh
//!
//! Transport abstraction layer for the Lattice communication platform.
//! Defines the MeshTransport trait and TransportManager.

pub mod error;
pub mod message;
pub mod peer;
pub mod transport;

pub use error::MeshError;
pub use message::MeshMessage;
pub use peer::{PeerCapabilities, PeerId, PeerInfo};
pub use transport::{MeshTransport, TransportCapabilities};

pub type Result<T> = std::result::Result<T, MeshError>;
