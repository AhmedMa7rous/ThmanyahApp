# ThmanyahApp | مساء الخير 🎧

A modern iOS SwiftUI application for discovering and browsing Arabic audio content including podcasts, audiobooks, episodes, and audio articles. Built with Clean Architecture principles and designed with Arabic-first user experience.

[![iOS](https://img.shields.io/badge/iOS-15.0+-blue)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-green)](https://developer.apple.com/xcode/swiftui/)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-red)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## 📱 Overview

ThmanyahApp is an Arabic audio content discovery platform that provides users with access to:

- **Podcasts** (بودكاست) - Audio series with multiple episodes
- **Episodes** (حلقة) - Individual podcast episodes  
- **Audio Books** (كتاب صوتي) - Complete audio books
- **Audio Articles** (مقال صوتي) - Short-form audio articles

### Key Features

- 🌙 **Dark Mode First** - Elegant dark theme optimized for extended listening sessions
- 🔍 **Smart Search** - Real-time search with history and debounced queries
- 📱 **Responsive Layouts** - Multiple layout types (grid, list, horizontal scroll)
- 🌐 **Arabic Support** - Full RTL support with custom Arabic fonts
- ♾️ **Infinite Scrolling** - Seamless content discovery with pagination
- 🎯 **Content Types** - Polymorphic content handling for different media types
- 🚀 **Modern Concurrency** - Built with Swift async/await and actors

## 🏗️ Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │     Domain      │    │      Data       │
│                 │    │                 │    │                 │
│ • Views         │◄──►│ • Models        │◄──►│ • DTOs          │
│ • ViewModels    │    │ • Use Cases     │    │ • Network       │
│ • Components    │    │ • Protocols     │    │ • Repositories  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Layers

**🎨 Presentation Layer**
- SwiftUI views with declarative UI
- MVVM pattern with `@MainActor` ViewModels
- Reusable component library
- Reactive state management with `@Published`

**💼 Domain Layer**
- Business logic and use cases
- Core models and entities
- Repository protocols (dependency inversion)
- Content protocol system for polymorphism

**🔗 Data Layer**
- Network service with Swift actors
- Repository implementations
- DTO mapping to domain models
- Comprehensive error handling

## 🚀 Getting Started

### Prerequisites

- **Xcode 15.0+**
- **iOS 15.0+** deployment target
- **Swift 5.0+**
- **macOS 12.0+** for development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AhmedMa7rous/ThmanyahApp.git
   cd ThmanyahApp
   ```

2. **Open in Xcode**
   ```bash
   open ThmanyahApp.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

### Configuration

The app connects to the following APIs:
- **Main API**: `https://api-v2-b2sit6oh3a-uc.a.run.app`
- **Search API**: `https://mock.apidog.com/m1/735111-711675-default`

API endpoints are configured in `APIConstants.swift` and can be modified for different environments.

## 📁 Project Structure

```
ThmanyahApp/
├── 📱 App/                          # App entry point
│   ├── ThmanyahAppApp.swift         # App configuration
│   └── ContentView.swift           # Root view with navigation
├── 🔧 Core/                         # Shared utilities
│   ├── Extensions/                  # Swift extensions
│   ├── Fonts/                       # IBMPlexSansArabic font family
│   └── Utils/                       # Constants, pagination, base classes
├── 🌐 Data/                         # External data sources
│   ├── DTOs/                        # Data transfer objects
│   ├── Mappers/                     # DTO to Domain mapping
│   ├── Network/                     # Networking layer
│   └── Repositories/                # Repository implementations
├── 💎 Domain/                       # Business logic
│   ├── Models/                      # Core entities
│   ├── RepositoryProtocols/         # Repository abstractions
│   └── UseCases/                    # Business use cases
├── 🎨 Presentation/                 # UI layer
│   ├── Components/                  # Reusable UI components
│   ├── Home/                        # Home feature
│   └── Search/                      # Search feature
└── 🧪 Tests/                        # Test suites
    ├── ThmanyahAppTests/            # Unit tests
    └── ThmanyahAppUITests/          # UI tests
```

## 🎯 Key Components

### Content System

The app uses a protocol-based content system for handling different media types:

```swift
protocol ContentProtocol {
    var id: String { get }
    var name: String { get }
    var avatarUrl: String { get }
    var contentType: ContentType { get }
    var duration: Int { get }
    var score: Double { get }
}
```

**Content Types:**
- `Podcast` - Podcast series with episode count
- `Episode` - Individual episodes with podcast reference
- `AudioBook` - Books with author information
- `AudioArticle` - Articles with author attribution

### Layout System

The app supports multiple section layout types:

- **Square Grid** (`square`) - 3-column grid for compact browsing
- **Two Lines Grid** (`2_lines_grid`) - 2-column horizontal scroll
- **Big Square** (`big_square`) - 2-column grid with larger items
- **Queue** (`queue`) - Vertical list with numbering

### Network Architecture

Built with modern Swift concurrency:

```swift
actor NetworkService: NetworkServiceProtocol {
    func request<T: Codable>(_ endpoint: APIEndpoint) async throws -> T
}
```

Features:
- Thread-safe networking with Swift actors
- Comprehensive error handling with typed errors
- Request cancellation support
- Timeout and retry logic
- JSON decoding with detailed error reporting

## 🎨 Design System

### Typography

- **Font Family**: IBM Plex Sans Arabic
- **Weights**: Regular, Medium, Bold
- **Localization**: Full Arabic support with RTL layout

### Color Palette

```swift
// Primary Colors
static let appOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
static let appBackground = Color.black
static let appCardBackground = Color.gray.opacity(0.1)

// Semantic Colors
static let appGray = Color(red: 0.15, green: 0.15, blue: 0.15)
static let appLightGray = Color(red: 0.25, green: 0.25, blue: 0.25)
```

### Layout Constants

```swift
struct Layout {
    static let cornerRadius: CGFloat = 12
    static let defaultPadding: CGFloat = 16
    static let smallPadding: CGFloat = 8
}
```

## 🧪 Testing

The project includes comprehensive test coverage:

### Unit Tests
- **Domain Logic**: Model validation, use case testing
- **Network Layer**: API endpoint testing, error handling
- **Repository Layer**: Data mapping, repository logic
- **ViewModels**: State management, business logic

### UI Tests
- **Home Flow**: Content loading, navigation
- **Search Flow**: Search functionality, history
- **Error Handling**: Network errors, retry logic

### Running Tests

```bash
# Unit Tests
cmd + U in Xcode

# Specific test file
xcodebuild test -scheme ThmanyahApp -destination 'platform=iOS Simulator,name=iPhone 15'

# Coverage Report
xcodebuild test -scheme ThmanyahApp -enableCodeCoverage YES
```

## 🔧 Development

### Code Style

- **SwiftLint** configuration for consistent code style
- **MVVM** pattern with SwiftUI
- **Dependency Injection** through initializers
- **Protocol-Oriented Programming** for testability

### Best Practices

1. **State Management**
   - Use `@Published` for reactive UI updates
   - Mark ViewModels with `@MainActor`
   - Implement proper loading states

2. **Error Handling**
   - Typed error enums with localized descriptions
   - Graceful degradation for network issues
   - User-friendly error messages

3. **Performance**
   - Lazy loading with pagination
   - Image caching with AsyncImage
   - Debounced search queries

### Adding New Features

1. **Domain First**
   ```swift
   // 1. Define your model
   struct NewContent: ContentProtocol { ... }
   
   // 2. Create use case
   class NewContentUseCase: NewContentUseCaseProtocol { ... }
   
   // 3. Update repository
   extension ContentRepository { ... }
   ```

2. **UI Implementation**
   ```swift
   // 4. Create ViewModel
   @MainActor class NewContentViewModel: ObservableObject { ... }
   
   // 5. Build SwiftUI View
   struct NewContentView: View { ... }
   ```

3. **Integration**
   ```swift
   // 6. Wire dependencies in ContentView
   ```

## 📋 API Reference

### Endpoints

**Home Sections**
```
GET /home_sections?page={page}
```

**Search**
```
GET /search?q={query}&page={page}&limit={limit}
```

### Response Models

**Home Response**
```json
{
  "sections": [
    {
      "name": "أحدث البودكاستات",
      "type": "square",
      "content_type": "podcast",
      "order": 1,
      "content": [...]
    }
  ],
  "pagination": {
    "next_page": "2",
    "total_pages": 10
  }
}
```

## 🚧 Known Issues

- Search API uses mock data (temporary)
- Image loading requires network connectivity
- Limited offline support

## 🛣️ Roadmap

- [ ] **Offline Support** - Download content for offline listening
- [ ] **User Accounts** - Personalization and sync
- [ ] **Audio Player** - Integrated playback controls
- [ ] **Favorites** - Save and organize content
- [ ] **Recommendations** - AI-powered content discovery
- [ ] **Social Features** - Share and discuss content

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit your changes** (`git commit -m 'Add amazing feature'`)
4. **Push to the branch** (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

### Development Setup

```bash
# Install dependencies (if any)
# Currently no external dependencies

# Run tests before committing
xcodebuild test -scheme ThmanyahApp

# Format code (if using SwiftFormat)
swiftformat .
```


## 👨‍💻 Author

**Ahmed Mahrous**
- GitHub: [@AhmedMa7rous](https://github.com/AhmedMa7rous)
- Email: ahmedmahros425@gmail.com

## 🙏 Acknowledgments

- **IBM Plex Sans Arabic** font family
- **Clean Architecture** by Robert C. Martin
- **SwiftUI** and modern iOS development patterns
- Arabic localization and RTL support

---

<div align="center">
  <p>Made with ❤️ for the Arabic audio content community</p>
  <p>مصنوع بحب لمجتمع المحتوى الصوتي العربي</p>
</div>
