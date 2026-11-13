# AGENTS.md — Machrou3kom (مشروعكم)

Guidance for AI agents (and humans) working in this repository.

## Project

An iOS app (`com.hamzajg.Machrouukom`) for discovering and sharing local
projects/initiatives (مشروعكم — "your project"): browse projects by
category and country, project details, create posts, notifications, user
profiles, contact, social links. Swift 4.0, UIKit, CocoaPods.
Backend: **Firebase** (Realtime Database, Storage, Messaging) + **Auth0**
auth. Images: AlamofireImage.

## Commands

**No CI.** Xcode project — builds need macOS + Xcode + CocoaPods.

| Task | Command |
|---|---|
| Install deps | `pod install` (Podfile: Firebase/Core, /Database, /Storage, /Messaging; Auth0 ~>1.0; AlamofireImage ~>3.3) |
| Build | open `Machrou3kom.xcworkspace` in Xcode, build/run |
| Test | Xcode test action (template tests only) |

Requires: Xcode + iOS SDK + CocoaPods; deployment target iOS 9.0–11.3,
Swift 4.0. `Machrou3kom.xcworkspace` is the Pods-integrated workspace —
open it after `pod install`.

## Architecture

```
Machrou3kom/
  Machrou3kom/
    AppDelegate.swift          Firebase/Auth0 init
    ViewController.swift
    SessionManager.swift       auth/session state
    Models/                    Post, User, Category, Country,
                               CountryAd, Notification, Social
    Services/AppServices.swift backend service layer (Firebase/Auth0)
    Controllers/
      HomeViewController.swift         feed by category/country
      CategoryViewController.swift
      CountryViewController.swift
      PostViewController.swift         post detail
      NewPostViewController.swift      create post
      UserProfileViewController.swift  profile
      NotificationViewController.swift notifications
      ContactUsViewController.swift
      Machrou3komViewController.swift
  Machrou3komTests/   Machrou3komUITests/   template tests
Machrou3kom.xcodeproj / .xcworkspace
Podfile / Podfile.lock            Firebase pods + Auth0 + AlamofireImage
Pods/                            (committed? check before pod install)
```

### Backend contract

Firebase Realtime Database + Storage + Cloud Messaging; Auth0 for
identity. Paths/endpoints are defined in `Services/AppServices.swift` +
`SessionManager.swift` — Firebase config (GoogleService-Info.plist) and
Auth0 credentials are in the Xcode project, not this doc. Treat
`AppServices.swift` as the contract source.

## Conventions

- UIKit + storyboards era Swift 4 — ViewControllers + Models +
  `AppServices`/`SessionManager` service layer.
- Firebase SDKs via CocoaPods — match existing pod usage.
- Auth0 handles login; `SessionManager` tracks session — don't bypass
  it with direct Firebase auth calls.
- Keep MVC-ish structure — no SwiftUI rewrite.

## Landmines

- **Default branch is `master`, not `main`.**
- **Swift 4.0 / iOS 9.0–11.3 deployment targets** — very legacy; modern
  Xcode may struggle.
- `Pods/` directory may be committed — check before `pod install`
  (don't commit pod changes blindly).
- Firebase config plist + Auth0 secrets live in the project — never
  commit new secrets; check `.gitignore`.
- Bundle id is `com.hamzajg.Machrouukom` (typo "Machrouukom" with extra
  u) — keep as-is, renaming breaks provisioning.
- Arabic-first app (مشروعكم) — UI strings/RTL matter.
- Template tests only — no real coverage.

## Agent rules

- Branch from `master`; name branches `feat/*`, `fix/*`, `chore/*`, `docs/*`.
- Docs-only changes still go through a PR; never commit to `master` directly.
- Verify before claiming: `pod install` + Xcode build — report honestly
  if you can't run Xcode.
- Backend changes must keep `AppServices.swift`/`SessionManager.swift`
  in sync — document the Firebase/Auth0 contract in
  docs/ARCHITECTURE.md.
- Keep changes minimal and consistent with surrounding code. No drive-by
  refactors.
- Update AGENTS.md / docs/ARCHITECTURE.md when pods, auth, or structure
  change.
