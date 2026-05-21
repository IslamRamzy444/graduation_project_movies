# Movies App (Graduation Project)

[![Flutter Version](https://img.shields.io/badge/Flutter-3.22-blue)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/State%20Management-BLoC-purple)](https://bloclibrary.dev/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-orange)](https://en.wikipedia.org/wiki/Model–view–viewmodel)

A full-featured movie browsing app with authentication, favorites, browsing by category, search, and watchlist. Built by a team of developers using MVVM architecture with BLoC. **I was the repository owner and team lead.**

> ⚠️ **Status Note**: The original authentication API is no longer deployed. **See demo videos below** for complete functionality demonstration.

---


## Demo Videos

| Phase | Link |
|-------|------|
| Phase 1 (Auth & Onboarding) | [Watch Demos] https://drive.google.com/file/d/1i8iOf_eGCG9IkzOtLRz9Y_s5nKo9Z6jN/view?usp=sharing |https://drive.google.com/file/d/1jLxoGLLfX0nKBYTqeEocyzGazIxx1xi5/view?usp=sharing
| Phase 2 (Home & edit profile & reset password) | [Watch Demo] https://drive.google.com/file/d/1d4SXEsbcPUdlIkgD9a-lG8Hc9gp5Wr4i/view?usp=sharing|
| Phase 3 (Movie Details) | [Watch Demo] https://drive.google.com/file/d/1bZjIm2lmHkKua6bVdF82Kv_VUfGthrJ9/view?usp=sharing|
| Phase 4 (Search & Profile& favorites) | [Watch Demo] https://drive.google.com/file/d/1mOS3tlO9gIfDUO8i7FwSYl2uwtd__GG5/view?usp=sharing |

---

## Features

| Feature | Description |
|---------|-------------|
| 🔐 **Authentication** | Register, login, reset password with validation |
| 👤 **User Profile** | View and update profile, change avatar |
| 🎬 **Home Screen** | Carousel slider with popular movies, category rows |
| 🔍 **Search** | Search movies by title |
| 📂 **Browse by Category** | 26 genres with pagination |
| ⭐ **Favorites** | Add/remove favorites with persistent storage (Hive) |
| 📄 **Movie Details** | Full info, cast, screenshots, similar movies |
| ▶️ **Watch Movie** | WebView integration to watch trailers |
| 🌍 **Localization** | English/Arabic support |
| 🎨 **Dark Theme** | Consistent dark UI throughout |

---

## Tech Stack

| Category | Technologies |
|----------|--------------|
| **Framework** | Flutter |
| **Architecture** | MVVM (Model-View-ViewModel) |
| **State Management** | BLoC / Cubit |
| **Local Storage** | Hive (favorites cache), SharedPreferences (token) |
| **Networking** | HTTP package |
| **Navigation** | Named routes with arguments |
| **Localization** | Flutter intl (arb files) |
| **UI** | Google Fonts, Carousel Slider, Toggle Switch |

---

## Project Structure
lib/
├── api/ # API constants, endpoints, manager
├── cubits/ # Global cubits (language, avatar)
├── models/ # All data models
├── ui/ # UI layer
│ ├── auth/ # Login, Register, ForgetPassword
│ ├── home/ # HomeScreen, CategoryItem, FilmCard
│ ├── browse/ # BrowseScreen with pagination
│ ├── search/ # SearchScreen
│ ├── profile/ # ProfileScreen, update profile
│ ├── movie_details/ # MovieDetails, Cast, Screenshots
│ └── widgets/ # Reusable widgets
├── utils/ # Routes, themes, colors, assets
└── l10n/ # Localization files (en/ar)


---

## Architecture Overview
┌─────────────────────────────────────────────────────────────┐
│ UI Layer │
│ (Screens + BlocBuilder / BlocListener) │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ BLoC / Cubit Layer │
│ (LoginViewModel, RegisterViewModel, BrowseCubit, etc.) │
└─────────────────────────────────────────────────────────────┘
│
▼
┌─────────────────────────────────────────────────────────────┐
│ API Layer │
│ (ApiManager - HTTP requests to YTS API + Auth API) │
└─────────────────────────────────────────────────────────────┘


---

## What This Project Shows

✅ **Team Leadership** — Repository owner, managed contributions  
✅ **MVVM Architecture** — Clear separation of concerns  
✅ **BLoC State Management** — Cubit pattern for predictable state  
✅ **API Integration** — Two separate APIs (YTS movies + custom auth)  
✅ **Local Storage** — Hive for favorites, SharedPreferences for auth token  
✅ **Pagination** — Browse screen loads more as you scroll  
✅ **Localization** — Full English/Arabic support  
✅ **Form Validation** — Real-time validation with error messages  
✅ **WebView Integration** — Watch trailers inside the app  

---

## What I'd Do Differently Today

- Replace the deprecated auth API with Firebase Authentication
- Add offline support for favorited movies
- Implement proper dependency injection
- Add unit and widget tests
- Use code generation for models (json_serializable)

---

## Setup Instructions

### Prerequisites
- Flutter SDK installed

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/IslamRamzy444/graduation_project_movies.git
   cd graduation_project_movies
   
2. **Get dependencies**
   ```bash
   flutter pub get

3. **Run the app**
   ```bash
   flutter run

> **Note**: The authentication API is currently offline. Use the demo videos above to see full functionality.
---
## My Role (Repository Owner)

- Managed team of multiple developers
- Implemented register and reset password
- Implemented the history tab of user profile with implementing caching logic
- Integrated movie details API
- Created watch now section with watch now screen and screenshots section
- Handled user API request logic

---
## Acknowledgments

- Movie data: [YTS API](https://yts.mx/api)
- Icons and assets: Various open sources
- Team members for collaboration

---
## Status

⚠️ Authentication API currently offline  
✅ App architecture and code structure fully intact  
✅ All features implemented and tested (see demo videos)  
⚠️ Legacy project from 2025 — kept for portfolio

---
## Connect With Me

- **GitHub**: [IslamRamzy444](https://github.com/IslamRamzy444)
- **LinkedIn**: [Islam Ramzy](https://www.linkedin.com/in/islamramzy/)
