# Architecture — Machrou3kom (مشروعكم)

Current-state map. Descriptive, not aspirational; see `docs/adr/` for why.

## Shape

```
Machrou3kom/                  iOS app — Swift 4.0, UIKit, CocoaPods
├── Machrou3kom/
│   ├── AppDelegate.swift          Firebase + Auth0 init
│   ├── ViewController.swift
│   ├── SessionManager.swift       auth/session state
│   ├── Models/                    Post, User, Category, Country,
│   │                              CountryAd, Notification, Social
│   ├── Services/AppServices.swift backend service layer
│   ├── Controllers/
│   │   ├── HomeViewController.swift          project feed
│   │   ├── CategoryViewController.swift      by category
│   │   ├── CountryViewController.swift       by country
│   │   ├── PostViewController.swift          post detail
│   │   ├── NewPostViewController.swift       create post
│   │   ├── UserProfileViewController.swift   profile
│   │   ├── NotificationViewController.swift  notifications
│   │   ├── ContactUsViewController.swift
│   │   └── Machrou3komViewController.swift
│   └── (storyboards/assets)
├── Machrou3komTests/         template tests
├── Machrou3komUITests/       template UI tests
├── Machrou3kom.xcodeproj
├── Machrou3kom.xcworkspace   Pods-integrated — open this
├── Podfile / Podfile.lock    Firebase (Core/Database/Storage/Messaging),
│                             Auth0 ~>1.0, AlamofireImage ~>3.3
└── Pods/                     CocoaPods output
```

## Flows

- **Auth:** Auth0 login → `SessionManager` holds session → Firebase
  rules/data access.
- **Browse:** `HomeViewController` → category/country filters →
  `PostViewController` detail.
- **Create:** `NewPostViewController` → Firebase Realtime DB + Storage.
- **Notify:** Firebase Cloud Messaging → `NotificationViewController`.
- **Profile/contact:** `UserProfileViewController`, `ContactUsViewController`.

## Frontend/backend contract

- **Firebase** RTDB + Storage + Messaging — paths in
  `Services/AppServices.swift`; config via GoogleService-Info.plist in
  the Xcode project.
- **Auth0** — identity provider; `SessionManager` bridges to Firebase.
- Contract source of truth: `AppServices.swift` + `SessionManager.swift`.

## State

Firebase RTDB is the backend state; client caches via Firebase SDK.
`SessionManager` is the auth/session singleton.
