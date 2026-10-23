# 04 Data and Content

## Offline first
Core features MUST work with no network. The network is optional and fails gracefully with a clear, localized message and a retry path.

## Data sources
- One responsibility each: one external source.
- Network sources set timeouts, support cancellation, and retry only idempotent calls with backoff.
- No user-visible text and no business rules in data sources.

## Static content vs user data
- Static content (read-only) and user data (mutable) live in SEPARATE stores. Updating content MUST NOT touch user data.
- Static content databases are produced by scripts, deterministically, and shipped as assets. They are never edited by hand.
- Every content build runs integrity tests (counts, checksums, required fields) and fails the build on any mismatch.
- User databases have versioned migrations, each covered by a test that upgrades from every older version.

## External content and licenses
Every external source (text, audio, fonts, datasets, images, icons) is recorded in `docs/SOURCES.md` with: name, purpose, license, obligations, link, date checked. No source is used before its entry exists. The in-app credits screen lists every source that requires attribution.

## Downloads
- Resumable, with size and integrity verification.
- Check free storage before starting.
- Ask for confirmation before large downloads on mobile data.
- Never block the UI. Show progress, support cancel, and report failures clearly.
- Large files are never committed to the repository.

## Dates and time zones
Store instants in UTC plus the location needed to interpret them. Calendar conversions go through ONE service so every screen agrees.

## Caching
Cache only what is expensive to recompute. Every cache has an invalidation rule and a size bound.
