# Voice Channels Specification

## Overview
Persistent audio rooms users can freely join/leave. Unlike Matrix calls, voice channels are always on.

## Matrix Mapping
A voice channel is a Matrix room with:
1. Custom state event `m.lattice.voice_channel`
2. Always-active MatrixRTC session (MSC3401)
3. Space membership

## State Event: m.lattice.voice_channel
Fields: name, bitrate (64000), user_limit (0=unlimited), codec (opus), push_to_talk_default, noise_suppression, echo_cancellation.

## Participant Tracking
Via MatrixRTC m.call.member with lattice_metadata: muted, deafened, self_video, streaming, speaking, push_to_talk_active.

## Push-to-Talk
Client-side mic gating. Default: muted. Key down: unmute + update membership. Key up: re-mute. Configurable key (default V on desktop). Toggles MediaStreamTrack.enabled for instant activation.

## Voice Activity Detection
WebRTC VAD or hark library. Configurable sensitivity. Updates speaking field.

## Game/Screen Streaming
WebRTC screen capture. VP9/AV1 codec. Published as additional video track. Stream metadata in membership.

## Permissions
| Permission | Power Level |
|---|---|
| Join | 0 |
| Speak | 0 |
| Stream | 10 |
| Mute Others | 50 |
| Move Members | 50 |
| Manage Channel | 100 |

## Mesh Mode
Voice only over Wi-Fi Direct. Direct WebRTC P2P. Max ~4-5 participants. Low bitrate Opus (16kbps).
