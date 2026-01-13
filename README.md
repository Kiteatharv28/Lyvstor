# Lvystor - E-Commerce Fashion App

A modern Flutter e-commerce application for fashion products with a complete shopping experience including product browsing, cart management, favorites, address management, and checkout flow.

## 📱 Project Overview

Lvystor is a full-featured e-commerce app built with Flutter and Firebase. It provides users with a seamless shopping experience with real-time data synchronization, user authentication, and comprehensive product management.

## 🏗️ Project Architecture

### Technology Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Authentication)
- **State Management**: Provider
- **UI Framework**: Material Design with Google Fonts

### Project Structure

```
lib/
├── main.dart                          # App entry point & authentication wrapper
├── pages/
│   └── home_page.dart                # Bottom navigation container
├── screens/
│   ├── auth_screen.dart              # Login/Registration
│   ├── home_screen.dart              # Featured products & live section
│   ├── category_screen.dart          # Product browsing & filtering
│   ├── product_detail_screen.dart    # Individual product details
│   ├── cart_screen.dart              # Shopping cart management
│   ├── checkout_screen.dart          # Order review
│   ├── address_selection_screen.dart # Address selection during checkout
│   ├── address_book_screen.dart      # Manage saved addresses
│   ├── add_edit_address_screen.dart  # Add/Edit address form
│   ├── payment_method_screen.dart    # Payment selection
│   ├── favourites_screen.dart        # Liked products
│   ├── profile_screen.dart           # User profile & settings
│   ├── orders_screen.dart            # Order history
│   ├── live_screen.dart              # Live shopping
│   └── live_detail_screen.dart       # Live session details
├── models/
│   ├── product_model.dart            # Product data structure
│   ├── cart_item_model.dart          # Cart item structure
│   ├── address_model.dart            # Address data structure
│   ├── order_model.dart              # Order data structure
├── providers/
│   ├── auth_provider.dart            # Authentication state
│   ├── product_provider.dart         # Products & categories state
│   ├── cart_provider.dart            # Shopping cart state
│   ├── address_provider.dart         # Addresses state
│   ├── favorites_provider.dart       # Favorites state
│   ├── order_provider.dart           # Orders state
├── services/
│   ├── auth_service.dart             # Firebase authentication
│   ├── product_service.dart          # Product data operations
│   ├── cart_service.dart             # Cart management
│   ├── address_service.dart          # Address management
│   ├── favorites_service.dart        # Favorites management
│   ├── order_service.dart            # Order management
│   └── seed_data_service.dart        # Initial data seeding
├── utils/
│   └── responsive.dart               # Responsive design utilities
└── widgets/
    └── skeleton_loader.dart          # Loading skeleton UI
```

## 🔄 Application Flow

### 1. Authentication Flow
```
App Start
    ↓
Firebase Initialization
    ↓
Check User Authentication
    ├─→ Not Authenticated → Auth Screen (Login/Register)
    │                           ↓
    │                      User Logs In
    │                           ↓
    └─→ Authenticated → Seed Data Check
                            ↓
                       Load Products & Categories
                            ↓
                       Bottom Navigation (Home)
```

### 2. Home Screen Flow
```
Home Screen
├─→ Browse Featured Products
│   ├─→ Click Like Button → Add to Favorites
│   └─→ Click Product → Product Detail Screen
├─→ Watch Live Section
│   └─→ Join Live Session
└─→ Discover Collections
    └─→ Browse by Category
```

### 3. Shopping Flow
```
Category Screen
    ↓
Browse Products
    ├─→ Filter by Category
    ├─→ Search Products
    ├─→ Sort by Price/Newest
    └─→ Click Like Button → Add to Favorites
    ↓
Click Product → Product Detail Screen
    ↓
Click "Add to Cart" → Cart Screen
    ↓
View Cart Items
    ├─→ Modify Quantities
    ├─→ Remove Items
    └─→ Click "Proceed to Checkout"
    ↓
Checkout Screen
    ├─→ Review Order Summary
    ├─→ Modify Quantities
    └─→ Click "Proceed to Address"
    ↓
Address Selection Screen
    ├─→ Select Existing Address
    ├─→ Add New Address → Address Book
    └─→ Click "Continue to Payment"
    ↓
Payment Method Screen
    ├─→ Select Payment Method
    └─→ Complete Order
```

### 4. Address Management Flow
```
Profile Screen
    ↓
Click "Address" → Address Book Screen
    ├─→ View All Addresses
    ├─→ Edit Address
    ├─→ Delete Address
    ├─→ Set as Default
    └─→ Add New Address → Add/Edit Address Screen
        ├─→ Fill Form (Name, Phone, Address, City, Pincode)
        ├─→ Validate Input
        └─→ Save to Firestore
```

### 5. Favorites Flow
```
Any Product Screen
    ↓
Click Heart Icon → Add to Favorites
    ↓
Profile Screen → Click Heart Icon
    ↓
Favorites Screen
    ├─→ View All Liked Products
    ├─→ Remove from Favorites
    └─→ Click Product → Product Detail
```

## 📊 Data Models

### Product
```dart
- id: String
- title: String
- description: String
- price: String
- originalPrice: String
- discount: String
- category: String
- inStock: bool
- image: String
- createdAt: DateTime
```

### Cart Item
```dart
- productId: String
- title: String
- price: String
- quantity: int
- maxStock: int
- image: String
```

### Address
```dart
- id: String
- name: String
- phone: String (10 digits)
- line1: String
- city: String
- pincode: String (6 digits)
- isDefault: bool
- updatedAt: DateTime
```

### Order
```dart
- id: String
- userId: String
- items: List<CartItem>
- totalAmount: int
- status: String
- createdAt: DateTime
```

## 🔐 Firebase Setup

### Collections Structure
```
categories/
├── gown/
├── kurti_sets/
├── kurta_sets/
└── coord_sets/

products/
├── prod_001/
├── prod_002/
└── ...

users/
├── {userId}/
│   ├── cart/
│   │   └── {productId}/
│   ├── addresses/
│   │   └── {addressId}/
│   ├── favorites/
│   │   └── {productId}/
│   └── orders/
│       └── {orderId}/
```

### Security Rules
- Users can only read/write their own data
- Categories and products are readable by authenticated users
- Write operations restricted to backend only

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Firebase project
- Android Studio or Xcode

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd lvystor
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
- Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
- Download configuration files:
  - Android: `google-services.json` → `android/app/`
  - iOS: `GoogleService-Info.plist` → `ios/Runner/`
- Update `lib/firebase_options.dart` with your credentials

4. **Run the app**
```bash
flutter run
```

## ✨ Key Features

### 1. Product Management
- Browse products by category
- Search and filter products
- Sort by price and newest
- View detailed product information
- Stock availability status

### 2. Shopping Cart
- Add/remove products
- Modify quantities
- Real-time price calculation
- Cart persistence across sessions

### 3. Favorites System
- Like/unlike products
- View all favorites
- Favorites persist in Firestore
- Visual feedback with heart icons

### 4. Address Management
- Add multiple addresses
- Edit existing addresses
- Delete addresses
- Set default address
- Full validation (phone: 10 digits, pincode: 6 digits)
- Demo addresses for testing

### 5. Checkout Flow
- Multi-step checkout process
- Address selection
- Payment method selection
- Order summary review
- Order confirmation

### 6. User Authentication
- Email/password registration
- Secure login
- Session persistence
- Logout functionality

### 7. Live Shopping
- Watch live sessions
- Join live shopping events
- Real-time interaction

## 🎨 UI/UX Features

- Responsive design (mobile, tablet, desktop)
- Gradient backgrounds
- Smooth animations
- Loading skeletons
- Empty states
- Error handling
- Toast notifications

## 📦 Seed Data

The app automatically seeds initial data on first launch:

### Categories (4)
- Gown
- Kurti Sets
- Kurta Sets
- Coord Sets

### Products (12)
- 3 products per category
- Complete product information
- Product images
- Pricing and discounts

### Demo Addresses (3)
- Home (Mumbai)
- Office (Bangalore)
- Parents House (Delhi)

## 🔄 State Management

Using Provider pattern for state management:

- **AuthProvider**: User authentication state
- **ProductProvider**: Products and categories
- **CartProvider**: Shopping cart items
- **AddressProvider**: User addresses
- **FavoritesProvider**: Liked products
- **OrderProvider**: User orders

## 🛡️ Data Persistence

All data persists in Firestore:
- User authentication
- Product catalog
- Shopping cart
- Addresses
- Favorites
- Orders

Data survives app restart and hot reload.

## 📱 Supported Platforms

- Android (API 21+)
- iOS (11.0+)
- Web (Chrome, Firefox, Safari)

## 🐛 Troubleshooting

### Firebase Connection Issues
- Verify Firebase credentials in `firebase_options.dart`
- Check internet connection
- Ensure Firestore security rules allow authenticated access

### Seed Data Not Loading
- Check Firebase project is active
- Verify Firestore collections are created
- Check user is authenticated

### Address Validation Errors
- Phone must be exactly 10 digits
- Pincode must be exactly 6 digits
- All fields are required

## 📝 Development Notes

### Adding New Products
Products are seeded automatically. To add more:
1. Update `seed_data_service.dart`
2. Add product to the products list
3. Restart app (seed data loads once)

### Customizing Categories
Edit categories in `seed_data_service.dart` seedCategories() method

### Modifying Checkout Flow
Update navigation in `checkout_screen.dart` and `address_selection_screen.dart`

## 🔒 Security Considerations

- Never commit Firebase credentials
- Use environment variables for sensitive data
- Validate all user inputs
- Implement proper error handling
- Use HTTPS for all communications

## 📄 License

This project is proprietary and confidential.

## 👥 Support

For issues or questions, contact the development team.

---

**Version**: 1.0.0  
**Last Updated**: January 2026  
**Status**: Production Ready
