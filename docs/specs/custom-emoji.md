# Custom Emoji & Stickers Specification

Custom emoji packs per-Space using MSC2545 extensions.

## State Event: m.lattice.emoji_pack

Each Space can have multiple packs as state events with images map.

## Usage Types
- `emoticon` — Small inline emoji (20-32px)
- `sticker` — Larger standalone (128-256px)

## Emoji Picker
Aggregates Unicode + all custom packs from joined Spaces. Search by shortcode, fuzzy matching, recent/frequently used.

## Reactions
Custom emoji as reaction key (MXC URI).

## Upload Constraints
- Max file size: 256 KB per emoji
- Formats: WebP, PNG, GIF, APNG
- Recommended: 128x128px
- Max per pack: 200
- Max packs per Space: 20

## Mesh Mode
Cached emoji work offline. Uncached show as :shortcode: text. Packs not synced over mesh (too large).
