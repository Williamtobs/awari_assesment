# Lumière — Fashion Mobile App

A Flutter implementation of the **[Lumière – Fashion mobile app](https://dribbble.com/shots/24747396-Lumi-re-Fashion-mobile-app)** Dribbble design, built **using only native Flutter & Dart widgets — zero external packages**.

The app reproduces the onboarding, home catalog, and product-detail experiences of a modern fashion store, with a responsive layout that keeps its visual integrity across phones, large devices, and tablets.

---

## ✨ Highlights

- **No third-party packages.** Everything — the marquee animation, the masonry grid, soft shadows, the size selector, the favorite toggle — is built from first principles using the Flutter SDK only. (`pubspec.yaml` ships with just `cupertino_icons` and the default lint/test SDKs.)
- **Professional, layered architecture** with a clear separation of core, data, and presentation concerns.
- **Responsive by design.** Layouts adapt to screen width using `LayoutBuilder` / `MediaQuery`, with a capped content width so the UI stays elegant on tablets.
- **Pixel-conscious styling.** Spacing, radii, and colors are centralized as design tokens for consistency across every screen.

---

## 📋 Requirements

| Tool | Version |
|------|---------|
| Flutter SDK | 3.10.0 or newer (stable channel) |
| Dart SDK | 3.10.0 or newer (bundled with Flutter) |
| Xcode | Required for iOS/macOS targets |
| Android Studio / Android SDK | Required for Android targets |

> The app loads product imagery from remote URLs, so the device or emulator needs **internet access** at runtime.

---

## 🚀 Setup & Run — Step by Step

### 1. Install Flutter
If you don't have Flutter yet, follow the official guide: <https://docs.flutter.dev/get-started/install>

Confirm your environment is healthy:

```bash
flutter doctor
```

Resolve any ❌ items it reports before continuing.

### 2. Clone the repository

```bash
git clone <your-repository-url>
cd lumi_fashion_mobile
```

### 3. Fetch dependencies

```bash
flutter pub get
```

### 4. List available devices

```bash
flutter devices
```

Start an emulator/simulator if none are connected:

```bash
# Android
flutter emulators --launch <emulator_id>

# iOS (macOS only)
open -a Simulator
```

### 5. Run the app

```bash
flutter run
```

To target a specific device:

```bash
flutter run -d <device_id>
```

### 6. (Optional) Build a release artifact

```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

### 7. (Optional) Run static analysis & tests

```bash
flutter analyze
flutter test
```

---

## 🧭 App Flow

```
OnboardingScreen  ──▶  HomeScreen  ──▶  ProductDetailScreen
   (marquee,           (search,           (gallery, size
    hero CTA)           filters,            selector, add
                        masonry grid)       to cart)
```

The entry point is `lib/main.dart`, which boots `MyApp` (`lib/src/app.dart`). `MyApp` configures the `MaterialApp` theme (background, font, visual density) and sets `OnboardingScreen` as the home route.

---

## 🏛️ Project Architecture

The codebase follows a **layered / feature-first architecture** inspired by Clean Architecture, keeping UI, data, and shared concerns decoupled and easy to navigate.

```
lib/
├── main.dart                       # App entry point
└── src/
    ├── app.dart                    # MaterialApp, theme & root route
    │
    ├── core/                       # Cross-cutting, app-wide building blocks
    │   ├── constants/
    │   │   ├── app_colors.dart     # Centralized color palette (design tokens)
    │   │   └── app_dimensions.dart # Spacing, radii & layout constraints
    │   └── widgets/
    │       ├── rounded_network_image.dart  # Reusable image with rounded corners
    │       └── soft_icon_button.dart        # Reusable soft-shadow icon button
    │
    ├── data/                       # Data layer — models & sources
    │   ├── models/
    │   │   └── product.dart        # Immutable Product model + helpers
    │   └── repositories/
    │       └── product_repository.dart  # In-memory product & category source
    │
    └── presentation/               # UI layer — organized by feature
        ├── onboarding/
        │   ├── view/
        │   │   └── onboarding_screen.dart
        │   └── widgets/
        │       └── custom_marquee.dart      # Hand-built scrolling marquee
        │
        ├── home/
        │   ├── view/
        │   │   └── home_screen.dart
        │   └── widgets/
        │       ├── home_top_bar.dart
        │       ├── home_search_field.dart
        │       ├── category_filter_bar.dart
        │       ├── product_masonry_grid.dart # Custom two-column masonry
        │       ├── product_card.dart
        │       ├── favorite_button.dart
        │       └── home_bottom_nav.dart
        │
        └── product_detail/
            ├── view/
            │   └── product_detail_screen.dart
            └── widgets/
                ├── detail_top_bar.dart
                ├── product_gallery.dart      # Swipeable image gallery
                ├── size_selector.dart
                └── add_to_cart_button.dart
```

### Layer responsibilities

| Layer | Folder | Responsibility |
|-------|--------|----------------|
| **Core** | `src/core` | Design tokens (colors, dimensions) and reusable, feature-agnostic widgets shared everywhere. |
| **Data** | `src/data` | The `Product` domain model and the `ProductRepository` that supplies catalog/category data. Swapping this for a real API later requires no UI changes. |
| **Presentation** | `src/presentation` | One folder per feature (`onboarding`, `home`, `product_detail`). Each feature splits into a `view/` (full screen) and `widgets/` (the smaller pieces that compose it). |

### Why this structure

- **Feature-first folders** keep everything for a screen in one place, so the app scales without files sprawling.
- **`view/` vs `widgets/` split** keeps screens thin and composable — each screen orchestrates small, single-responsibility widgets.
- **Centralized design tokens** (`AppColors`, `AppDimensions`) guarantee consistent padding, radii, and colors, and make global restyling trivial.
- **Repository abstraction** isolates the data source so the UI never hard-codes where products come from.

---

## 🎨 Design Tokens

All styling flows from two token files so the look stays consistent and tunable from one place:

- **`app_colors.dart`** — the warm cream background, ink text, muted greys, soft fills, and accent colors.
- **`app_dimensions.dart`** — a spacing scale (`xs`→`xl`), corner radii, screen padding, and `maxContentWidth` (520) that caps layout width on large screens for a balanced look.

---

## 📱 Responsiveness

- Screens use `LayoutBuilder` / `MediaQuery` to adapt to the available width.
- A maximum content width keeps the design centered and readable on tablets and large displays.
- The masonry grid and spacing scale fluidly rather than overflowing on smaller phones.

---

## 🧩 Built Without Packages

Every interactive or visual effect that would typically pull in a dependency was reimplemented natively, for example:

| Effect | Typical package | Built here with |
|--------|-----------------|-----------------|
| Scrolling marquee | `marquee` | Custom `AnimationController` in `custom_marquee.dart` |
| Masonry / staggered grid | `flutter_staggered_grid_view` | Hand-laid two-column layout in `product_masonry_grid.dart` |
| Cached network images | `cached_network_image` | `Image.network` wrapped in `rounded_network_image.dart` |
| Icon styling / soft buttons | various UI kits | `soft_icon_button.dart` using `Container` + `BoxShadow` |

---

## 🛠️ Tech Stack

- **Flutter** (Material) — UI framework
- **Dart** — language
- **Native widgets only** — no external Flutter/Dart packages

---

## 📄 License

This project was created as a UI implementation exercise based on a Dribbble design. Product imagery is loaded from Unsplash for demonstration purposes.
