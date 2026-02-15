//! # lattice-core
//!
//! Core library for the Lattice communication platform.
//! Wraps matrix-rust-sdk and provides shared types, session management,
//! room management, and the sync engine.

pub mod error;

pub use error::LatticeError;

/// Result type alias for Lattice operations
pub type Result<T> = std::result::Result<T, LatticeError>;
