//! Mesh message envelope format.

use serde::{Deserialize, Serialize};
use crate::peer::PeerId;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[repr(u8)]
pub enum MessageType {
    Data = 0,
    Ack = 1,
    Ping = 2,
    Pong = 3,
    RelayRequest = 4,
    RelayAck = 5,
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize)]
pub struct MessageFlags {
    pub relay_requested: bool,
    pub is_fragment: bool,
    pub is_last_fragment: bool,
    pub ack_required: bool,
}

impl Default for MessageFlags {
    fn default() -> Self {
        Self { relay_requested: true, is_fragment: false, is_last_fragment: false, ack_required: true }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct MeshMessage {
    pub version: u8,
    pub msg_type: MessageType,
    pub msg_id: [u8; 16],
    pub src_peer: PeerId,
    pub dst_peer: PeerId,
    pub hop_count: u8,
    pub max_hops: u8,
    pub timestamp_ms: u64,
    pub flags: MessageFlags,
    pub fragment_seq: Option<u16>,
    pub payload: Vec<u8>,
}

impl MeshMessage {
    pub const DEFAULT_MAX_HOPS: u8 = 7;
    pub const BLE_MAX_PAYLOAD: usize = 400;
    pub const WIFI_MAX_PAYLOAD: usize = 65536;
    pub const LORA_MAX_PAYLOAD: usize = 200;
}
