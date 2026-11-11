# Machrou3kom

An iOS app for discovering and sharing local projects and initiatives
(مشروعكم — "your project").

## What it does

`Machrou3kom` lets users browse projects by category and country, open a
project's details, create new posts, and receive notifications. It includes
user profiles, contact screens, and social links.

## Tech stack

- **Language:** Swift
- **Platform:** iOS (UIKit), CocoaPods
- **Backend:** Firebase (Realtime Database, Storage, Messaging, Core)
- **Auth:** Auth0
- **Images:** AlamofireImage

## Project layout

```
Machrou3kom/
  Machrou3kom/
    Controllers/   # view controllers (home, category, post, profile, …)
    Models/        # Country, Category, Post, User, Notification, Social, …
    Views/         # reusable views
    SessionManager.swift
  Machrou3komTests/
  Machrou3komUITests/
  Machrou3kom.xcworkspace
Podfile
```

## Building

Open `Machrou3kom.xcworkspace` in Xcode, or install pods first:

```bash
cd Machrou3kom
pod install
open Machrou3kom.xcworkspace
```

Dependencies: Firebase (Core, Database, Storage, Messaging), Auth0 1.x,
AlamofireImage 3.x.

## Configuration

The app expects `GoogleService-Info.plist` (Firebase) and `Auth0.plist`
(Auth0 domain/client id) in the app target. These are present for the original
development project; replace them with your own Firebase and Auth0 settings
before building a separate deployment.

## Tests

- `Machrou3komTests` — unit tests
- `Machrou3komUITests` — UI tests

Run them from Xcode (`Product ▸ Test`) on a simulator.

## Status

Legacy iOS project. It uses old pod majors (Auth0 1.x, AlamofireImage 3.x) and
a pre-scene-delegate UIKit structure; modernizing it would mean updating the
pods and iOS project settings.
