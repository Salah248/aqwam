# 02 UI and Design

## Design tokens
- Colors, spacing, radii, elevation, motion and type styles come ONLY from the token theme extension. No `Color(0x...)`, no literal paddings, radii or font sizes in widgets (a literal `0` or `1` for hairlines is allowed).
- Light and dark must use the same token names. A widget must work in both themes without branching on the theme.
- Tokens are defined once in `core/theme`. A new token is added to the design source first, then to code.

## Text and localization
- No hard-coded user-visible strings. Use ARB files. Plurals and gender via ICU messages. Never build sentences by concatenation.
- Numbers and dates are formatted ONLY by the shared formatters in `core/utils`.
- Every new string exists in all supported languages in the same PR.

## RTL first
- Use directional APIs: `EdgeInsetsDirectional`, `AlignmentDirectional`, `start`/`end`. No `left`/`right` for layout.
- Icons that imply direction (back, next, chevrons) MUST mirror.

## Responsiveness and text scale
- No fixed widths or heights that assume one device. Support 320 dp wide phones up to tablets.
- Layouts MUST survive system text scale up to 200 percent with no overflow or clipped text.

## Accessibility
- Touch targets at least 48 x 48 dp.
- Contrast at least 4.5:1 for text, 3:1 for large text (18 sp+ or 14 sp bold) and meaningful icons. Check both themes.
- Every interactive or informative element has a semantic label. Reading order is logical.
- Color is never the only carrier of meaning.
- Respect the system "reduce motion" setting.

## Screen states
Every screen that loads or depends on data MUST define: loading (skeleton, not a bare spinner where layout is known), empty, error with a retry action, and success. Add: offline and permission-denied when relevant. These states are part of the design review.

## Widget rules
- Widgets are small and focused. Extract when a `build` method exceeds roughly 80 lines or repeats a pattern.
- Use `const` constructors wherever possible.
- Rebuild narrowly: `BlocSelector`/`buildWhen`/`context.select`. Never create a Cubit inside `build`.
- No business logic, parsing or IO in widgets.
- Lists use builder constructors with stable keys.
- Navigation through named routes in the router. No raw `Navigator.push` of widgets.
- Animation durations and curves come from motion tokens.

## Icons and assets
One icon family. Vector assets (SVG) for ornaments and illustrations. Every asset is declared in `pubspec.yaml`, and its license is recorded.

## Fidelity to the design
Build from the design reference named in the task. The PR lists every intentional deviation and why. Compare both themes, RTL, and 200 percent text scale before requesting review.
