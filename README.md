# TikTok Style Vertical Video Feed 🎬

A TikTok-inspired vertical video feed application built with Flutter.
The project demonstrates modern Flutter development practices including Clean Architecture, BLoC state management, dependency injection, API integration, video caching, and optimized video playback.

---

## 📱 Project Overview

This project is a vertical scrolling video feed similar to TikTok.

Users can:

- Browse videos in a full-screen vertical feed.
- Automatically play the currently visible video.
- Pause previous videos when scrolling.
- Cache videos locally for smoother playback.
- Like videos locally.
- Search videos using keywords.
- Handle loading, empty, and failure states.
- Experience optimized memory management while scrolling.

The videos are fetched from:

**Pexels Video API**

---

# ✨ Features

## 🎥 Video Feed

- TikTok-style vertical scrolling using `PageView.builder`.
- Full-screen immersive video experience.
- Automatic playback of the visible video.
- Previous videos are paused automatically.
- Supports infinite-like feed behavior.

---

## ▶️ Video Playback

Implemented using:

- `video_player`
- `cached_video_player_plus`

Features:

- Auto play current video.
- Pause previous video.
- Loop playback.
- Tap on video to pause/play.
- Thumbnail shown before initialization.
- Error handling during playback.

---

## 🚀 Video Caching & Preloading

A custom:

```
VideoPlaybackManager
```

was implemented to optimize video performance.

Responsibilities:

- Manage video controllers globally.
- Prevent multiple videos playing simultaneously.
- Preload the next video before user reaches it.
- Store downloaded videos in local cache.
- Dispose unused controllers to avoid memory leaks.

Flow:

```
User opens video
        |
        ↓
Check local cache
        |
        ↓
Video exists?
        |
   Yes -------- No
    |            |
 Play       Download
              |
              ↓
          Save in cache
              |
              ↓
             Play
```

---

# 🏗️ Architecture

The project follows:

## Clean Architecture

Structure:

```
lib
│
├── core
│   ├── api
│   ├── exceptions
│   ├── helper
│   ├── resources
│   ├── routes
│   └── services
│
├── data
│   ├── models
│   ├── datasource
│   └── repository
│
├── domain
│   ├── entity
│   ├── repository
│   └── usecase
│
└── presentation
    ├── bloc
    ├── screens
    └── widgets
```

---

# 🔄 State Management

Used:

```
flutter_bloc
```

Pattern:

```
Event
  |
  ↓
Bloc
  |
  ↓
UseCase
  |
  ↓
Repository
  |
  ↓
API
```

Implemented events:

### Fetch Videos

Responsible for:

- Loading videos.
- Refreshing feed.
- Searching videos.

---

### Toggle Like

Responsible for:

- Changing like state locally.
- Updating like counter.

---

# 🌐 API Integration

API:

```
Pexels Video API
```

Implemented using:

```
Dio
```

Features:

- Request handling.
- Error mapping.
- Logging in debug mode.
- API key injection.

---

# 🔐 Environment Variables

API key is stored securely using:

```
flutter_dotenv
```

Example:

```
key.env
```

Content:

```
PEXELS_API_KEY=your_api_key_here
```

The file is excluded from GitHub.

---

# 🧩 Dependency Injection

Implemented using:

```
get_it
injectable
```

Registered dependencies:

- VideoFeedBloc
- Repository
- DataSource
- UseCases
- NetworkHelper


Initialization:

```
configureDependencies();
```

---

# 🎨 UI Implementation

The UI follows a TikTok-style design.

Implemented widgets:

## VideoPlayerItem

Responsible for:

- Displaying video.
- Playback controls.
- Loading state.
- Thumbnail fallback.


## VideoActionBar

Contains:

- User avatar.
- Like button.
- Comment button.
- Share button.


## VideoDescription

Contains:

- Username.
- Video caption.


## CustomBottomNavigation

TikTok-style bottom navigation.

---

# 📐 Responsive Design

The project uses:

```
flutter_screenutil
```

All dimensions are handled using:

```
AppWidth
AppHeight
AppPadding
AppRadius
AppSize
```

No hardcoded UI dimensions are used.

Example:

Instead of:

```dart
padding: EdgeInsets.all(16)
```

Used:

```dart
padding: EdgeInsets.all(AppPaddingWidth.p15)
```

---

# 🛡️ Error Handling

Implemented states:

## Loading

Displays loading UI while fetching videos.


## Empty

Displayed when API returns no videos.


## Failure

Handles:

- No internet connection.
- API errors.
- Invalid API key.
- Server errors.

---

# 📦 Packages Used

## State Management

```
flutter_bloc
equatable
```

---

## Networking

```
dio
pretty_dio_logger
connectivity_plus
```

---

## Dependency Injection

```
get_it
injectable
injectable_generator
```

---

## Video

```
video_player
cached_video_player_plus
flutter_cache_manager
visibility_detector
```

---

## Utilities

```
flutter_dotenv
flutter_screenutil
go_router
json_serializable
cached_network_image
```

---

# 🔑 API Configuration

Create a file:

```
key.env
```

Add:

```
PEXELS_API_KEY=YOUR_API_KEY
```

Then run:

```
flutter pub get
```

---

# ▶️ Running The Project

Clone repository:

```bash
git clone <repository-url>
```

Navigate:

```bash
cd tiktok
```

Install packages:

```bash
flutter pub get
```

Generate files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run:

```bash
flutter run
```

---

# 📸 Screens

## Video Feed

- Full screen vertical videos.
- Auto playback.
- TikTok style actions.


## Loading State

- Smooth loading indicator.
- Skeleton information.


## Empty State

- Friendly empty screen.


## Error State

- Retry functionality.

---

# 🧠 Technical Decisions

## Why Clean Architecture?

To achieve:

- Separation of responsibilities.
- Easier testing.
- Maintainability.
- Scalability.


## Why BLoC?

Because:

- Predictable state changes.
- Clear event/state flow.
- Suitable for large applications.


## Why Cached Video Playback?

Because:

- Reduces network usage.
- Improves user experience.
- Prevents buffering while scrolling.

---

# 🚧 Future Improvements

Possible improvements:

- Real backend authentication.
- Real comments system.
- Real likes API.
- User profiles.
- Infinite pagination.
- Upload videos.
- Offline-first database.

---

# 👩‍💻 Developer

** Fatena Ahmad **
Flutter Developer

Built with Flutter ❤️
