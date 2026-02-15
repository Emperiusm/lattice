//! Lattice CLI - TUI client for development and testing

use anyhow::Result;
use tracing_subscriber::EnvFilter;

#[tokio::main]
async fn main() -> Result<()> {
    tracing_subscriber::fmt()
        .with_env_filter(EnvFilter::from_default_env())
        .init();

    tracing::info!("Lattice CLI starting...");
    println!("Lattice v{} - CLI Client", env!("CARGO_PKG_VERSION"));
    println!("Development preview. See README.md for details.");

    Ok(())
}
