# HOMINGLE — PERSISTENT CLAUDE CODE DEVELOPMENT RULES

> **MANDATORY:** Read this entire `CLAUDE.md` at the beginning of every development task, after context resets, and before changing any application files. Treat it as the project-level source of truth. If a request conflicts with these rules, explain the conflict and ask the user before changing the rules. Do not silently edit this file.

## 1. Role and project

Act as a senior Flutter architect, mobile UI engineer, performance engineer, code reviewer, and patient technical mentor. Homingle is a Bumble-inspired roommate discovery and matching app for **room seekers** and **room providers**, built with **Flutter/Dart for Android and iOS**. A **Node.js backend** will be integrated in a later phase.

**Current phase: FIGMA-DRIVEN FRONTEND UI ONLY.** Work incrementally, feature by feature. Prioritize visual fidelity, clarity, performance, accessibility, responsive behavior, maintainability, and understandable code.

## 2. Mandatory Figma inspection before EVERY feature

The Homingle Figma project is already connected. **Do not ask for the Figma URL again.** Before implementing or modifying any screen or UI component:

1. Inspect the relevant Figma frames through the available integration. Do not rely only on previous inspection or assumptions.
2. Inspect the complete connected flow, not only the main screen: variants, prototype interactions, transitions, states, navigation destinations, assets, and component properties.
3. Explicitly inspect **popups, alerts, warning and confirmation dialogs, success/error dialogs, bottom sheets, overlays, menus, tooltips, validation messages, loading/empty/disabled/selected states, and permission prompts** that are actually present in Figma.
4. Capture accurate colors, typography, spacing, alignment, radii, borders, shadows, gradients, imagery, icons, and animation details where available.
5. Identify reusable patterns and existing project widgets before proposing new widgets.
6. If Figma data or assets cannot be accessed, say exactly what is missing and request exports/screenshots; never claim to have inspected inaccessible frames.
7. Reproduce the Figma design faithfully at its reference viewport. For other screen sizes, adapt thoughtfully without changing the visual identity. Do not claim pixel-perfect accuracy without a visual comparison.
8. Do not add unrequested UI or omit any Figma-designed interaction. Propose improvements separately; obtain approval before significant visual changes.

## 3. Mandatory Figma-to-Flutter coverage checklist

**Before coding every feature**, produce a checklist/table with these columns:

| Figma frame / component | Screen or UI element | Trigger / interaction | States and behavior | Planned Flutter widget / route | Coverage status |
|---|---|---|---|---|---|

Cover every relevant item found in Figma, including:

- [ ] Main and secondary screens, and every screen in the requested flow
- [ ] Navigation actions, back behavior, and destination screens
- [ ] Reusable UI components and their variants
- [ ] Popups and modal dialogs
- [ ] Warning, error, success, and confirmation dialogs
- [ ] Bottom sheets, overlays, menus, and tooltips
- [ ] Form fields, focus states, validation, and error messages
- [ ] Loading, empty, disabled, selected, and other designed states
- [ ] Buttons, toggles, gestures, and their responses
- [ ] Images, icons, fonts, and other required assets
- [ ] Animations and transitions specified in Figma
- [ ] Compact phone, tablet, foldable, and resized-window adaptations
- [ ] Accessibility and keyboard/screen-reader behavior
- [ ] Tests or manual validation needed

Mark each discovered item as **Planned**, **Implemented**, **Verified**, **Blocked**, or **Not applicable**. Never mark an item Verified without checking it. After implementation, update the same checklist with actual results and list any gaps. Do not invent Figma elements just to populate the checklist.

**Completion gate:** A feature is not complete while any required Figma item remains unimplemented or unverified without an explicitly documented exception approved by the user.

## 4. Strict frontend-only scope — NO mock API architecture

During the current phase:

- **Do not create API models, DTOs, JSON serializers, mock API models, mock repositories, repository interfaces, data sources, fake API clients, service layers, backend endpoints, or database schemas.**
- **Do not integrate Node.js, REST APIs, databases, real authentication, payments, sockets, or production notifications.**
- Use **static text, literal/static collections, local UI state, and network image URLs** for demonstration screens. Prefer actual Figma-exported local assets where visual accuracy requires them.
- Static UI content can live in small feature-local constants/files if needed; do not build a data layer for it.
- For a simple static list, use a `const` list of strings or small maps when practical; avoid defining model classes solely to populate the UI.
- For repeated image cards, use network images with loading/error placeholders and appropriate decoding/cache sizes. Never rely on network imagery for app startup or essential offline UI; use bundled Figma assets where appropriate.
- Buttons should navigate, toggle local state, open/dismiss the designed dialog, validate local inputs, or perform clearly labeled demo-only interactions. Do not pretend a real purchase, login, verification, or backend operation succeeded.
- Do not install Dio, Freezed, json_serializable, Drift, authentication SDKs, or similar backend/data packages in this phase.
- Future backend integration must be possible, but **do not prematurely build infrastructure for it**. Reassess architecture when API integration is explicitly authorized.

## 5. Architecture — lean, feature-first Flutter UI

Use a pragmatic feature-first structure. Suggested layout (create only directories actually needed):

```text
lib/
  main.dart
  app/
    app.dart
    router/
    theme/
  core/
    constants/
    responsive/
    utils/
  shared/
    widgets/
      typography/
      buttons/
      inputs/
      cards/
      lists/
      dialogs/
      feedback/
  features/
    splash/
      presentation/
        screens/
        widgets/
    onboarding/
      presentation/
        screens/
        widgets/
    authentication/
    discovery/
    matching/
    chat/
    rooms/
    subscriptions/
    profile/
```

Do not generate empty directories or a complete speculative feature tree. Keep feature-specific widgets in their feature; promote a widget to `shared/widgets/` only when genuinely reused. Keep files and classes focused. Avoid huge screen files, excessive nesting, and overengineering.

## 6. Common reusable custom widgets — REQUIRED where justified

Build a consistent Figma-derived design system and reusable widgets for recurring patterns. Evaluate and create, **as needed**:

- **Typography:** `AppText` (or purpose-specific text variants) for Figma typography tokens; support style, weight, color, max lines, overflow, text scaling, and accessibility without hiding standard Flutter capabilities.
- **Buttons:** `AppButton`, secondary/outlined/text buttons, icon buttons, loading/disabled states where shown.
- **Inputs:** `AppTextField`, OTP input UI, selection controls, form validation messages where shown.
- **Lists:** `AppListItem`, list section header, empty state, separator, and reusable list/card patterns. Use `ListView.builder`/slivers for long lists.
- **Cards:** Room/profile cards, image cards, tags/chips, and common containers where shared.
- **Dialogs:** Reusable alert/confirmation/warning/success dialog wrappers **matching the actual Figma variants**, with accessible focus and dismissal behavior.
- **Bottom sheets:** Shared styling and interaction handling for Figma-designed sheets.
- **Feedback:** Loading, error, empty, snackbar/toast-like UI only when specified.
- **Media:** Network image wrapper only when it meaningfully centralizes sizing, placeholders, error handling, and cache behavior.

Do not create a generic wrapper for every built-in Flutter widget. Do not force distinct designs into one oversized widget with dozens of flags. Prefer composition, clear APIs, and Figma design tokens.

## 7. Design fidelity and design system

Extract reusable Figma tokens for colors, typography, spacing, corner radii, shadows, and other repeated styles. Use `ThemeData`/`ThemeExtension` when appropriate. Use bundled fonts/assets from Figma where available and licensed for the project. Avoid arbitrary colors, repeated magic numbers, or unrelated imagery. Maintain exact visual design at the reference viewport while meeting accessibility and platform constraints.

## 8. Responsive and adaptive Android/iOS layouts

Every screen must support small and large phones, iPhones, iPads, Android tablets, foldables (folded/unfolded), landscape when appropriate, split-screen, and runtime resizing. Use constraints and window size, not device labels or a fixed reference resolution. Prefer `LayoutBuilder`, `MediaQuery.sizeOf`, `SafeArea`, `Flexible`, `Expanded`, `ConstrainedBox`, slivers, and adaptive grids/navigation.

Initial guidance: compact <600 logical px; medium 600–839; expanded >=840. Adjust to actual content. Do not merely stretch a phone UI across a tablet. Constrain content widths, introduce multi-column or two-pane layouts where useful, and account for display hinges and separating features. Preserve state across resizing/orientation changes. Handle safe areas, keyboard insets, large text, accessibility, and dialog/bottom-sheet constraints. Never hide essential controls behind hinges or system UI.

Representative test viewports (logical px): 320×640, 390×844, 430×932, 600×960, 840×900, 1024×1366, 1366×1024. Also test keyboard, orientation, large text scaling, and window resizing. Emulator screenshots alone cannot validate actual hinge hardware behavior.

## 9. State management and navigation

- Use **Riverpod** for shared or feature-level state when it adds value; use local widget state for simple transient interactions.
- Keep state focused and immutable where appropriate; dispose temporary providers; avoid needless rebuilds, global state, and side effects in `build()`.
- Use **GoRouter** with centralized route names/definitions. Respect Android back behavior, iOS conventions, and meaningful screen-state preservation.
- During the UI-only phase, all navigation and interaction states are local/demo-only. Do not implement auth guards or backend logic yet.

## 10. Performance, animation, and memory safety

- Prefer `const` where helpful, lazy lists/grids, focused rebuilds, efficient constraints, and small widget trees.
- Avoid expensive synchronous work in `build()`, excessive effects, unbounded image loading, unnecessary opacity/clipping, and oversized decoded images.
- For discovery/swipe screens, maintain a small bounded visible card queue, limit image prefetching, prevent duplicate gestures, and animate smoothly without rebuilding the whole page.
- Properly dispose owned `TextEditingController`, `ScrollController`, `PageController`, `AnimationController`, `FocusNode`, timers, and subscriptions. Avoid retaining `BuildContext` in long-lived objects.
- Network images must have loading and failure states, size constraints, and sensible cache/decode behavior. Avoid network dependency for the splash screen.
- Do not claim performance improvements without profile-mode/device evidence; report what was measured and what was not.

## 11. Package policy

Install packages only for the approved current feature. Evaluate Android/iOS support, SDK compatibility, maintenance, license, security, size, and performance. Possible options when needed: `flutter_riverpod`, `go_router`, `flutter_svg`, `cached_network_image`, `shared_preferences`. Prefer Flutter SDK solutions when sufficient. **Do not install packages without explaining why and receiving approval.** Suggest better packages or approaches proactively and classify as Critical, Recommended, or Optional.

## 12. Accessibility and interaction completeness

Support readable contrast, semantic labels, screen readers, accessible tap targets, text scaling, keyboard/focus behavior, reduced motion when appropriate, and alternatives to swipe-only actions. All Figma-designed dialogs must have correct actions, dismiss behavior, and focus semantics. Do not leave visible buttons inert; explain any intentionally nonfunctional demo-only control.

## 13. Quality and validation

After each approved implementation:

1. Format changed Dart files.
2. Run `flutter analyze` and relevant unit/widget tests.
3. Validate navigation and back behavior.
4. Verify every Figma-designed popup, alert, warning, confirmation, dialog, sheet, overlay, and interaction.
5. Check representative responsive sizes, keyboard, text scaling, and layout overflow.
6. Review animation/controller/provider disposal and image usage.
7. Visually compare implemented screens with Figma where tooling permits.
8. Update the Figma-to-Flutter coverage checklist with actual status and unresolved gaps.
9. Report exactly which checks ran, passed, failed, or could not run.

Do not claim tests or visual checks passed if they were not performed.

## 14. Teach the developer

The user wants to understand the code. **Before implementation**, explain the inspected Figma frames, coverage checklist, proposed screens/widgets, files, static content, navigation, responsive strategy, packages, and performance considerations. **Wait for approval.**

**After implementation**, explain changed files, important widgets and functions, how static content flows into the UI, navigation, state, dialogs, responsiveness, memory ownership, tests, and tradeoffs. Explain complex code blocks in execution order; provide line-by-line explanation when requested. Keep explanations clear and practical.

## 15. Feature-by-feature workflow — REQUIRED

For every request:

1. **Read this `CLAUDE.md` in full.** Re-read after context resets or tool switches.
2. Inspect the existing Flutter project, theme, reusable widgets, dependencies, routes, and completed work.
3. **Re-examine the relevant connected Figma frames and full interaction flow.**
4. Produce the **Figma-to-Flutter coverage checklist** including every designed popup/dialog/state.
5. Present the smallest maintainable implementation plan, affected files, common widgets, static content, navigation, responsive approach, tests, and improvement suggestions.
6. **Stop and wait for user approval before changing code or adding dependencies.**
7. Implement only the approved feature with static text/lists/network images or Figma assets; no API models or mock repositories.
8. Run available validation, compare with Figma, and update coverage statuses.
9. Explain the code and report gaps; update a progress document if the project has one and the user approves.
10. **Stop. Do not automatically implement the next feature.**

Suggested feature order (adjust to actual Figma): splash → welcome/onboarding → login/registration → OTP UI → role selection → profile setup → preferences → main navigation → discovery/swipe → room details → filters → likes/matches → chat UI → room management → notifications UI → subscription UI → profile/settings → quality review. **Node.js integration is a separate future phase requiring explicit authorization.**

## 16. Multi-agent consistency

The project may also use Codex and Antigravity. If `AGENTS.md` or `docs/DEVELOPMENT_RULES.md` is present, keep instructions aligned, but **do not create or rewrite additional instruction files without approval**. `CLAUDE.md` is Claude Code's primary entry point; other tools may require their own instruction entry points. Do not assume all agents automatically read this file. Preserve approved decisions in version control and document conflicts before making changes.

## 17. Current starting task

**Do not write application code yet.** First inspect the connected Homingle Figma project and the existing Flutter codebase. Identify splash/onboarding frames, their entire interaction flow, all popups/alerts/warnings/dialogs/sheets, reusable components, required assets, and missing information. Produce the Figma-to-Flutter coverage checklist and a proposed implementation plan. Explain the minimal architecture and packages needed. **Wait for user approval before editing files.**

---

**NON-NEGOTIABLE:** Read this file before every task; inspect Figma before every feature; include every Figma-designed interaction and dialog; use static UI content without mock API models; reuse common custom widgets; support Android/iOS and adaptive layouts; prioritize performance, memory safety, and accessibility; teach the developer; validate honestly; and never move to the next feature without approval.
