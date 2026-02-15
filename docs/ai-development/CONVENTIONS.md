# AI Development Conventions

## Issue Workflow Labels

```
ai:needs-spec → ai:ready → ai:in-progress → ai:review → [merged/closed]
```

## Branch Naming
```
<type>/<issue-number>-<short-description>
```

## Commit Messages
Conventional Commits: `<type>(<scope>): <description>` with `Refs: #<issue>`

Types: feat, fix, refactor, docs, test, ci, chore
Scopes: core, mesh, mesh-ble, mesh-wifi, mesh-lora, dtn, voice, moderation, homeserver, cli, desktop

## Approved Dependencies
tokio, async-trait, futures, serde, serde_json, thiserror, anyhow, tracing, tracing-subscriber, matrix-sdk, btleplug, ratatui, crossterm, rand

## Banned
- No `unwrap()` in library crates
- No `println!()` in library crates (use tracing)
- No `std::thread` (use tokio tasks)
- No blocking I/O in async contexts

## Testing
- Unit tests: `#[cfg(test)] mod tests` in same file
- Test naming: `test_<function>_<scenario>_<expected>`
- Use `#[tokio::test]` for async tests
- Mock external dependencies
