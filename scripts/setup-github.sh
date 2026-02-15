#!/usr/bin/env bash
# Lattice GitHub Project Setup Script
# Creates labels and milestones (issues already created via MCP)
# Usage: GITHUB_OWNER=Emperiusm GITHUB_REPO=lattice ./scripts/setup-github.sh
# Requires: gh CLI authenticated
set -euo pipefail

OWNER="${GITHUB_OWNER:?Set GITHUB_OWNER}"
REPO="${GITHUB_REPO:-lattice}"

echo "Setting up GitHub project: $OWNER/$REPO"

# === LABELS ===
echo "Creating labels..."
cl() { gh label create "$1" --color "$2" --description "$3" --repo "$OWNER/$REPO" --force 2>/dev/null || true; }

# Components
cl "comp:core"       "0052cc" "lattice-core crate"
cl "comp:voice"      "0075ca" "lattice-voice crate"
cl "comp:moderation" "0096c7" "lattice-moderation crate"
cl "comp:mesh"       "00b4d8" "lattice-mesh transport abstraction"
cl "comp:mesh-ble"   "48cae4" "BLE mesh transport"
cl "comp:mesh-wifi"  "90e0ef" "Wi-Fi Direct mesh transport"
cl "comp:mesh-lora"  "ade8f4" "LoRa mesh transport"
cl "comp:dtn"        "caf0f8" "Delay-tolerant networking"
cl "comp:homeserver" "023e8a" "Embedded Conduit homeserver"
cl "comp:emoji"      "0077b6" "Custom emoji and stickers"
cl "comp:presence"   "023047" "Rich presence and activity"
cl "comp:cli"        "0a3d62" "CLI/TUI client"
cl "comp:desktop"    "1e3a5f" "Desktop Tauri client"
cl "comp:mobile"     "2c5f7c" "Mobile client"
cl "comp:e2ee"       "001d3d" "End-to-end encryption"
cl "comp:federation" "003566" "Matrix federation"

# Types
cl "type:feature"  "2da44e" "New feature"
cl "type:bug"      "d73a4a" "Bug fix"
cl "type:refactor" "fbca04" "Code refactoring"
cl "type:docs"     "0075ca" "Documentation"
cl "type:infra"    "e4e669" "CI/CD, tooling"
cl "type:research" "d876e3" "Research spike"
cl "type:adr"      "c5def5" "Architecture Decision Record"

# Priority
cl "P0:critical" "b60205" "Blocking, fix now"
cl "P1:high"     "d93f0b" "Important for milestone"
cl "P2:medium"   "e99d42" "Should do this milestone"
cl "P3:low"      "f9d0c4" "Nice to have"

# AI workflow
cl "ai:ready"       "6f42c1" "Fully specified, AI can implement"
cl "ai:needs-spec"  "d4c5f9" "Needs human clarification"
cl "ai:in-progress" "9b59b6" "AI agent working on this"
cl "ai:review"      "8e44ad" "AI completed, needs human review"

# Size
cl "size:XS" "ededed" "< 1 hour"
cl "size:S"  "d4d4d4" "1-4 hours"
cl "size:M"  "b0b0b0" "4-16 hours"
cl "size:L"  "888888" "16-40 hours"
cl "size:XL" "666666" "40+ hours"

# Phase
cl "phase:1-discord"    "1d6d37" "Phase 1: Discord parity"
cl "phase:2-homeserver" "2d8a4e" "Phase 2: Embedded homeserver"
cl "phase:3-mesh"       "3da663" "Phase 3: Mesh transport"
cl "phase:4-advanced"   "4dc47a" "Phase 4: Advanced features"

echo "Labels done ($(gh label list --repo $OWNER/$REPO --json name | python3 -c 'import sys,json;print(len(json.load(sys.stdin)))') labels)."

# === MILESTONES ===
echo "Creating milestones..."
cm() {
  gh api "repos/$OWNER/$REPO/milestones" --method POST \
    -f title="$1" -f description="$2" -f due_on="$3" -f state="open" 2>/dev/null || true
}

cm "v0.1.0 - Foundation" "Project setup, matrix-rust-sdk integration, CI/CD, basic client shell" "2026-04-01T00:00:00Z"
cm "v0.2.0 - Text Messaging" "Rooms, Spaces, threads, reactions, read receipts" "2026-06-01T00:00:00Z"
cm "v0.3.0 - Voice & Video" "MatrixRTC, voice channels, push-to-talk" "2026-08-01T00:00:00Z"
cm "v0.4.0 - Discord Features" "Custom emoji, rich presence, streaming" "2026-10-01T00:00:00Z"
cm "v0.5.0 - Moderation Suite" "Roles, ban lists, audit logs, auto-mod" "2026-12-01T00:00:00Z"
cm "v0.6.0 - Embedded Homeserver" "Conduit integration, local-first, offline" "2027-03-01T00:00:00Z"
cm "v0.7.0 - Mesh Transport" "BLE discovery, Wi-Fi Direct, text over mesh" "2027-06-01T00:00:00Z"
cm "v0.8.0 - DTN & Sync" "Store-and-forward, state reconciliation" "2027-09-01T00:00:00Z"
cm "v0.9.0 - Mesh Advanced" "LoRa, mesh voice, relay optimization" "2027-12-01T00:00:00Z"
cm "v1.0.0 - Production" "Security audit, performance, docs" "2028-03-01T00:00:00Z"

echo "Milestones done."
echo ""
echo "Setup complete! Now apply labels to existing issues:"
echo "  gh issue edit 1 --add-label 'type:feature,comp:core,P0:critical,ai:ready,size:M,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 2 --add-label 'type:feature,comp:core,P1:high,ai:ready,size:M,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 3 --add-label 'type:infra,P0:critical,ai:ready,size:S,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 4 --add-label 'type:feature,comp:mesh,P1:high,ai:ready,size:M,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 5 --add-label 'type:feature,comp:cli,P1:high,ai:ready,size:L,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 6 --add-label 'type:adr,type:docs,P2:medium,ai:ready,size:S,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 7 --add-label 'type:feature,comp:core,P1:high,ai:ready,size:L,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 8 --add-label 'type:feature,comp:core,P2:medium,ai:ready,size:M,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 9 --add-label 'type:feature,comp:voice,P0:critical,ai:ready,size:XL,phase:1-discord' --repo $OWNER/$REPO"
echo "  gh issue edit 10 --add-label 'type:feature,comp:mesh-ble,P0:critical,ai:ready,size:XL,phase:3-mesh' --repo $OWNER/$REPO"
echo "  gh issue edit 11 --add-label 'type:feature,comp:mesh-wifi,P1:high,ai:ready,size:XL,phase:3-mesh' --repo $OWNER/$REPO"
echo "  gh issue edit 12 --add-label 'type:feature,comp:dtn,P1:high,ai:ready,size:XL,phase:3-mesh' --repo $OWNER/$REPO"
echo "  gh issue edit 13 --add-label 'type:feature,comp:dtn,P0:critical,ai:ready,size:XL,phase:3-mesh' --repo $OWNER/$REPO"
echo "  gh issue edit 14 --add-label 'type:research,comp:mesh,P2:medium,ai:ready,size:L,phase:3-mesh' --repo $OWNER/$REPO"
echo "  gh issue edit 15 --add-label 'type:feature,comp:moderation,P1:high,ai:ready,size:L,phase:1-discord' --repo $OWNER/$REPO"
