# SwiftUI Practice

A complete SwiftUI iOS application demonstrating the **Improved Navigation Architecture** (Coordinator pattern) with per-tab NavigationPath, feature-scoped routes, deep link support, and comprehensive tab management.

## Features

- ✨ **Splash Screen**: Animated app launch with smooth transitions
- 🔐 **Authentication Flow**: Welcome, Login, and Registration screens
- 🏠 **Home Tab**: User profile header with scrollable post feed
- 📝 **List Tab**: Full-screen post list view
- 👤 **Account Tab**: Complete user profile with logout
- 📄 **Post Details**: Detailed post view with author information
- 🌐 **API Integration**: JSONPlaceholder API for posts and users
- 🎨 **Modern Design**: Clean UI with custom color scheme and SF Symbols

## Architecture

### Improved Navigation Pattern
- **Centralized Router**: `AppRouter` manages all navigation state
- **Per-Tab NavigationPaths**: Independent navigation stacks for each tab
- **Type-Safe Routes**: Feature-scoped enum-based routing
- **Deep Link Ready**: Infrastructure for URL-based navigation

### Tech Stack
- SwiftUI (iOS 16+)
- Async/await for networking
- Combine for state management
- MVVM architecture
- JSONPlaceholder API

## Project Structure

```
SwiftUIPractice/
├── App/                    # App entry point
├── Navigation/             # Router and route definitions
├── Models/                 # Data models (Post, User)
├── Services/               # Network layer
├── ViewModels/             # Business logic
├── Views/                  # UI components
│   ├── Splash/
│   ├── Auth/
│   ├── Main/
│   ├── Home/
│   ├── List/
│   ├── Account/
│   └── PostDetail/
└── Extensions/             # Theme and utilities
```

## How to Build

### Option 1: Create New Xcode Project
1. Open Xcode
2. Create a new **iOS App** project
3. Choose **SwiftUI** interface
4. Set **iOS 16.0** as minimum deployment target
5. Copy all Swift files from this repository to your project
6. Ensure all files are added to the target
7. Build and run

### Option 2: Use Existing Project
1. Clone this repository
2. Open in Xcode as a package or add files to your existing project
3. Build and run

## Usage

### Authentication
- Launch the app and see the splash screen
- Choose **Login** or **Register** from the welcome screen
- Enter any non-empty credentials (mock authentication)
- You'll be redirected to the main tab view

### Navigation
- **Home Tab**: Browse posts with user header
- **List Tab**: View all posts in a list format
- **Account Tab**: See user profile and logout
- Tap any post to view details

### API
The app fetches real data from JSONPlaceholder:
- Posts: `https://jsonplaceholder.typicode.com/posts`
- Users: `https://jsonplaceholder.typicode.com/users`

## Key Components

### AppRouter
```swift
@MainActor
final class AppRouter: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var activeTab: Tab = .home
    @Published var homePath = NavigationPath()
    // ... per-tab navigation paths
}
```

### Feature Routes
```swift
enum HomeRoute: Hashable {
    case postDetail(postId: Int)
}
```

### ViewModels
All ViewModels use:
- `@MainActor` for UI thread safety
- `@Published` for reactive updates
- Async/await for data fetching
- Loading, error, and success states

## Design System

### Colors
- Primary: Blue (#3366CC)
- Secondary: Light Blue (#4D7FE6)
- Accent: Orange (#FF9933)
- Adaptive system colors for light/dark mode

### Typography
- SF Pro Display for headings
- SF Pro Text for body
- Consistent font weights and sizes

### Components
- Rounded cards with 12px radius
- Grouped sections with labels
- Loading states with ProgressView
- Error states with retry buttons

## Requirements

- iOS 16.0+
- Xcode 14.0+
- Swift 5.7+

## Documentation

See [IMPLEMENTATION.md](IMPLEMENTATION.md) for detailed architecture documentation and implementation notes.

## License

This is a practice project for learning SwiftUI navigation patterns.

## Author

Built to demonstrate modern SwiftUI best practices and the Improved Navigation Architecture pattern.