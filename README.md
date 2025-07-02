# 🎓 SnapDeals - Educational Marketplace

A comprehensive Flutter application that connects students and educators, enabling seamless buying and selling of educational products and courses with real-time chat, notifications, and marketplace management.

## 📱 Screenshots

### 🎯 Onboarding & Authentication
| Splash Screen | Onboarding 1 | Onboarding 2 | Onboarding 3 |
|---------------|--------------|--------------|--------------|
| ![Splash Screen](screenshots/splach.png) | ![Onboarding 1](screenshots/onboarding1.png) | ![Onboarding 2](screenshots/onboarding2.png) | ![Onboarding 3](screenshots/onboarding3.png) |

| User Registration | Login | Forgot Password | Profile |
|-------------------|-------|-----------------|---------|
| ![User Registration](screenshots/regoster.png) | ![Login](screenshots/login_screen.png) | ![Forgot Password](screenshots/forgetpassword.png) | ![Profile](screenshots/profile.png) |

### 🏠 Home & Discovery
| Main Home | Category Search | Product Details | Course Details |
|-----------|----------------|-----------------|----------------|
| ![Main Home](screenshots/home.png) | ![Category Search](screenshots/categorysearch.png) | ![Product Details](screenshots/product_details.png) | ![Course Details](screenshots/course_details.png) |

### 📚 Products & Courses
| Add Product | Add Course Details | My Products | Course Details 2 |
|-------------|-------------------|-------------|------------------|
| ![Add Product](screenshots/add%20product.png) | ![Add Course Details](screenshots/add%20coursedetails.png) | ![My Products](screenshots/my%20product.png) | ![Course Details 2](screenshots/course_details2.png) |

### 💬 Chat & Communication
| Chat List | Chat Interface | Messages |
|-----------|----------------|----------|
| ![Chat List](screenshots/chats.png) | ![Chat Interface](screenshots/chat.png) | ![Messages](screenshots/chat.png) |

### ⭐ Favorites & Requests
| Favorites | Course Orders |
|-----------|---------------|
| ![Favorites](screenshots/fav_product.png) | ![Course Orders](screenshots/course_ordars.png) |

### 🔔 Notifications & Settings
| Notifications | Settings | Change Language |
|---------------|----------|-----------------|
| ![Notifications](screenshots/notification.png) | ![Settings](screenshots/settinga.png) | ![Change Language](screenshots/chamge%20clang.png) |

### 👤 User Management
| Edit Profile | Change Password | Privacy Policy |
|--------------|-----------------|----------------|
| ![Edit Profile](screenshots/edituserprofie.png) | ![Change Password](screenshots/changepassword.png) | ![Privacy Policy](screenshots/privacy.png) |

### 🛠️ Additional Features
| About Us | Logout | Guest Mode |
|----------|--------|------------|
| ![About Us](screenshots/aboutus.png) | ![Logout](screenshots/logout.png) | ![Guest Mode](screenshots/gest.png) |

## 🚀 Features

### 👤 User Features
- **User Registration & Authentication** - Secure signup/login with Firebase Auth
- **Educational Product Discovery** - Browse and search for educational products and courses
- **Course & Product Listings** - View detailed information about courses and products
- **Real-time Chat** - Communicate with sellers and support through in-app messaging
- **Push Notifications** - Get notified about new messages, requests, and updates
- **Profile Management** - Update personal information and preferences
- **Favorites System** - Save and manage favorite products and courses
- **Multi-language Support** - Arabic and English localization with RTL support

### 🛍️ Marketplace Features
- **Product & Course Creation** - Add new educational products and courses with rich details
- **Image & Media Support** - Upload multiple images and media files
- **Category Management** - Organize products by educational categories
- **Pricing & Location** - Set prices and specify locations for products
- **Search & Filter** - Advanced search and filtering capabilities
- **Contact Information** - Direct contact with sellers through call or chat

### 💬 Communication Features
- **Real-time Messaging** - Instant chat between buyers and sellers
- **Message Types** - Text, audio, image, video, and file messages
- **Message Status** - Sent, delivered, and read receipts
- **Offline Support** - Messages sync when connection is restored
- **Push Notifications** - Real-time message notifications
- **Chat Rooms** - Organized chat rooms for different conversations

### 🔔 Notification System
- **Message Alerts** - Instant chat message notifications
- **Request Updates** - Status change notifications for requests
- **Product Updates** - New product and course notifications
- **System Notifications** - App updates and important announcements

### 👨‍💼 Admin Features
- **User Management** - View and manage user accounts
- **Category Management** - Add, edit, and delete product categories
- **Content Moderation** - Review and moderate user-generated content
- **Analytics Dashboard** - Track platform usage and metrics

## 🛠️ Requirements

- **Flutter SDK** (>=3.4.3)
- **Dart SDK** (>=3.4.3)
- **Android Studio** or **VS Code**
- **Firebase Account** (for backend services)
- **Supabase Account** (for additional backend features)

## 📦 Dependencies

### Core Dependencies
- `flutter_bloc` - State management with BLoC pattern
- `firebase_core` - Firebase initialization
- `firebase_auth` - User authentication
- `cloud_firestore` - Database operations
- `firebase_storage` - File storage
- `firebase_messaging` - Push notifications
- `supabase_flutter` - Additional backend services

### UI & Navigation
- `go_router` - App navigation and routing
- `flutter_svg` - SVG image support
- `shimmer` - Loading animations
- `loading_animation_widget` - Custom loading animations
- `eva_icons_flutter` - Icon library

### Data & Storage
- `hive_flutter` - Local database for offline support
- `cached_network_image` - Image caching
- `geolocator` - Location services
- `google_maps_flutter` - Maps integration

### Media & Communication
- `image_picker` - Image selection from gallery/camera
- `video_player` - Video playback
- `flutter_sound` - Audio recording/playback
- `record` - Audio recording
- `file_picker` - File selection
- `get_thumbnail_video` - Video thumbnail generation

### Utilities
- `dio` - HTTP client for API calls
- `intl` - Internationalization
- `uuid` - Unique ID generation
- `equatable` - Value equality
- `dartz` - Functional programming
- `device_preview` - Device preview for development
- `flutter_localizations` - Localization support

## ✅ Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/snap-deals.git
   cd snap_deals
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project
   - Add your `google-services.json` to `android/app/`
   - Add your `GoogleService-Info.plist` to `ios/Runner/`
   - Enable Authentication, Firestore, Storage, and Cloud Messaging

4. **Configure Supabase:**
   - Create a Supabase project
   - Update the Supabase URL and anon key in `lib/main.dart`

5. **Run the app:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── app/
│   ├── admin_feature/      # Admin panel and management
│   ├── auth_feature/       # User authentication and profiles
│   ├── category/           # Category browsing and management
│   ├── chat_feature/       # Real-time messaging system
│   ├── home_feature/       # Main home screen and navigation
│   ├── notification/       # Push notification system
│   ├── on_board_feature/   # App introduction screens
│   ├── product_feature/    # Product and course management
│   └── request_feature/    # Request system for users
├── core/
│   ├── constants/          # App constants and configurations
│   ├── extensions/         # Dart extensions
│   ├── localization/       # Multi-language support
│   ├── themes/            # App theming and colors
│   └── utils/             # Utility functions and helpers
└── main.dart              # App entry point
```

## 🧪 Running Tests

```bash
flutter test
```

## 📦 Building for Release

### Android APK:
```bash
flutter build apk --release
```

### Android App Bundle:
```bash
flutter build appbundle --release
```

### iOS:
```bash
flutter build ios --release
```

## 🌐 Localization

The app supports multiple languages:
- **English** (en) - Default language
- **Arabic** (ar) - RTL support

To add new languages:
1. Add new ARB files in `lib/core/localization/l10n/`
2. Run `flutter gen-l10n` to generate localization files
3. Update the language selection in the app

## 🔧 Configuration

### Firebase Configuration
- **Authentication**: Email/Password authentication
- **Firestore**: Database for users, products, courses, and chat
- **Storage**: Image and file storage for media
- **Cloud Messaging**: Push notifications

### Supabase Configuration
- **Real-time database**: For chat messages and notifications
- **Additional backend services**: Enhanced functionality

### Local Storage (Hive)
- **Chat messages**: Offline message storage
- **User preferences**: App settings and preferences
- **Favorites**: Local favorite items storage

## 🎨 Design System

- **Color Scheme**: Modern blue and white theme
- **Typography**: Lora (English) and Noto Kufi Arabic (Arabic) fonts
- **Icons**: Eva Icons and Material Design icons
- **Responsive Design**: Adapts to different screen sizes

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@snapdeals.com or create an issue in this repository.

---

**Built with ❤️ using Flutter for the educational community**