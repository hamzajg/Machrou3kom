# ADR 0001 — Initial architecture

Date: 2026-11-13 (baseline recorded retroactively)
Status: accepted (describes what is built)

## Context

An Arabic-first local-projects discovery/sharing app for iOS — needed
auth, realtime data, storage, and push without building a backend.

## Decisions

1. **Firebase as backend.** Realtime Database + Storage + Cloud
   Messaging via CocoaPods. Rationale: zero-backend realtime data +
   push for a mobile-first app.
2. **Auth0 for identity.** `SessionManager` bridges Auth0 sessions to
   Firebase. Rationale: Auth0 gives social/enterprise auth options
   Firebase Auth alone didn't cover at the time.
3. **UIKit + Swift 4, CocoaPods.** Era-typical iOS stack; MVC-ish
   ViewControllers + `AppServices`/`SessionManager` service layer.
   Rationale: period-appropriate, simple.
4. **AlamofireImage for remote images.** Pod. Rationale: standard
   async image loading.
5. **Arabic-first UI.** App name/content in Arabic (مشروعكم) — RTL and
   Arabic strings are first-class. Rationale: target audience.

## Consequences / open questions

- **Very legacy toolchain** — Swift 4.0, iOS 9–11.3 deployment targets;
  modern Xcode compatibility is a known cost.
- Firebase security rules + Auth0 config live outside the repo — the
  client can't be audited for data exposure from code alone.
- Bundle id typo (`Machrouukom`) is load-bearing for provisioning.
- No real tests — template only.
