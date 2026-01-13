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
- price: int
- originalPrice: int
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

### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a new project"
3. Enter project name: "Lvystor"
4. Enable Google Analytics (optional)
5. Click "Create project"

### Step 2: Register Apps

**For Android:**
1. Click "Android" icon in Firebase console
2. Enter package name: `com.example.lvystor`
3. Enter app nickname: `Lvystor Android`
4. Download `google-services.json`
5. Place it in `android/app/` directory

**For iOS:**
1. Click "iOS" icon in Firebase console
2. Enter bundle ID: `com.example.lvystor`
3. Enter app nickname: `Lvystor iOS`
4. Download `GoogleService-Info.plist`
5. Place it in `ios/Runner/` directory (add to Xcode)

### Step 3: Update Firebase Options
1. Open `lib/firebase_options.dart`
2. Replace placeholder values with your Firebase credentials:
```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'YOUR_ANDROID_API_KEY',
  appId: '1:YOUR_PROJECT_NUMBER:android:YOUR_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'YOUR_IOS_API_KEY',
  appId: '1:YOUR_PROJECT_NUMBER:ios:YOUR_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'your-project-id',
  databaseURL: 'https://your-project-id.firebaseio.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

### Step 4: Enable Firestore Database
1. In Firebase console, go to "Firestore Database"
2. Click "Create database"
3. Select "Start in test mode" (for development)
4. Choose region closest to you
5. Click "Enable"

### Step 5: Enable Authentication
1. Go to "Authentication" in Firebase console
2. Click "Get started"
3. Enable "Email/Password" provider
4. Click "Enable" and "Save"

### Step 6: Deploy Security Rules
1. Go to "Firestore Database" → "Rules" tab
2. Replace the default rules with the content from `firestore.rules`
3. Click "Publish"

## 📊 Firestore Collections & Data Model

### Collections Structure

```
firestore/
├── categories/
│   ├── gown/
│   │   ├── name: "Gown"
│   │   └── createdAt: timestamp
│   ├── kurti_sets/
│   │   ├── name: "Kurti Sets"
│   │   └── createdAt: timestamp
│   ├── kurta_sets/
│   │   ├── name: "Kurta Sets"
│   │   └── createdAt: timestamp
│   └── coord_sets/
│       ├── name: "Coord Sets"
│       └── createdAt: timestamp
│
├── products/
│   ├── prod_001/
│   │   ├── title: "Premium Gown"
│   │   ├── description: "Elegant premium gown for special occasions"
│   │   ├── price: 1299
│   │   ├── originalPrice: 1599
│   │   ├── discount: "18%"
│   │   ├── category: "Gown"
│   │   ├── categoryId: "gown"
│   │   ├── stockQty: 15
│   │   ├── inStock: true
│   │   ├── image: "assets/card1.png"
│   │   ├── createdAt: timestamp
│   │   └── updatedAt: timestamp
│   └── prod_002/
│       └── ... (similar structure)
│
└── users/
    └── {userId}/
        ├── cart/
        │   └── {productId}/
        │       ├── productId: "prod_001"
        │       ├── title: "Premium Gown"
        │       ├── price: "1299"
        │       ├── quantity: 2
        │       ├── maxStock: 15
        │       ├── image: "assets/card1.png"
        │       └── updatedAt: timestamp
        │
        ├── addresses/
        │   └── {addressId}/
        │       ├── name: "Home"
        │       ├── phone: "9876543210"
        │       ├── line1: "123 Main Street, Apartment 4B"
        │       ├── city: "Mumbai"
        │       ├── pincode: "400001"
        │       ├── isDefault: true
        │       └── updatedAt: timestamp
        │
        ├── favorites/
        │   └── {productId}/
        │       ├── productId: "prod_001"
        │       └── addedAt: timestamp
        │
        └── orders/
            └── {orderId}/
                ├── userId: "{userId}"
                ├── items: [CartItem]
                ├── totalAmount: 2598
                ├── status: "pending"
                ├── addressId: "{addressId}"
                ├── paymentMethod: "credit_card"
                ├── createdAt: timestamp
                └── updatedAt: timestamp
```

### Data Models

#### Product
```json
{
  "id": "prod_001",
  "title": "Premium Gown",
  "description": "Elegant premium gown for special occasions",
  "price": 1299,
  "originalPrice": 1599,
  "discount": "18%",
  "category": "Gown",
  "categoryId": "gown",
  "stockQty": 15,
  "inStock": true,
  "image": "assets/card1.png",
  "createdAt": "2024-01-12T10:30:00Z",
  "updatedAt": "2024-01-12T10:30:00Z"
}
```

#### Cart Item
```json
{
  "productId": "prod_001",
  "title": "Premium Gown",
  "price": "1299",
  "quantity": 2,
  "maxStock": 15,
  "image": "assets/card1.png",
  "updatedAt": "2024-01-12T10:30:00Z"
}
```

#### Address
```json
{
  "name": "Home",
  "phone": "9876543210",
  "line1": "123 Main Street, Apartment 4B",
  "city": "Mumbai",
  "pincode": "400001",
  "isDefault": true,
  "updatedAt": "2024-01-12T10:30:00Z"
}
```

#### Order
```json
{
  "userId": "{userId}",
  "items": [
    {
      "productId": "prod_001",
      "title": "Premium Gown",
      "price": "1299",
      "quantity": 2,
      "maxStock": 15,
      "image": "assets/card1.png"
    }
  ],
  "totalAmount": 2598,
  "status": "pending",
  "addressId": "{addressId}",
  "paymentMethod": "credit_card",
  "createdAt": "2024-01-12T10:30:00Z",
  "updatedAt": "2024-01-12T10:30:00Z"
}
```

## 🌱 Seeding Data

### Automatic Seed Data

The app automatically seeds data on first user login:

**Categories (4):**
- Gown
- Kurti Sets
- Kurta Sets
- Coord Sets

**Products (12):**
- 3 products per category
- Complete product information
- Product images
- Pricing and discounts

**Demo Addresses (3):**
- Home (Mumbai)
- Office (Bangalore)
- Parents House (Delhi)

### How Seed Data Works

1. **First App Launch**
   - User logs in
   - App checks if products exist in Firestore
   - If empty → Automatically seeds all data
   - If exists → Skips seeding (no duplicates)

2. **Manual Seeding**
   - Go to Profile → Address
   - Click "Add Demo Addresses" button
   - 3 demo addresses added to your account

3. **Seed Data Service**
   - Located in `lib/services/seed_data_service.dart`
   - `seedAllData()` - Seeds categories and products
   - `seedCategories()` - Seeds 4 categories
   - `seedProducts()` - Seeds 12 products
   - `clearAllData()` - Clears all data (for testing)

### Seed Data Details

**Categories:**
```dart
[
  {'id': 'gown', 'name': 'Gown'},
  {'id': 'kurti_sets', 'name': 'Kurti Sets'},
  {'id': 'kurta_sets', 'name': 'Kurta Sets'},
  {'id': 'coord_sets', 'name': 'Coord Sets'},
]
```

**Products Sample:**
```dart
{
  'title': 'Premium Gown',
  'description': 'Elegant premium gown for special occasions',
  'price': 1299,
  'originalPrice': 1599,
  'discount': '18%',
  'category': 'Gown',
  'categoryId': 'gown',
  'stockQty': 15,
  'inStock': true,
  'image': 'assets/card1.png',
}
```

**Demo Addresses:**
```dart
[
  {
    'name': 'Home',
    'phone': '9876543210',
    'line1': '123 Main Street, Apartment 4B',
    'city': 'Mumbai',
    'pincode': '400001',
  },
  {
    'name': 'Office',
    'phone': '9876543211',
    'line1': '456 Business Park, Suite 200',
    'city': 'Bangalore',
    'pincode': '560001',
  },
  {
    'name': 'Parents House',
    'phone': '9876543212',
    'line1': '789 Residential Colony, House No. 42',
    'city': 'Delhi',
    'pincode': '110001',
  },
]
```

## 🔐 Security Rules Deployment

### Security Rules Overview

The app uses Firestore security rules to protect user data:

**Key Rules:**
- Users can only read/write their own data
- Categories and products are readable by authenticated users
- Write operations restricted to backend only
- Orders cannot be deleted
- Cart and addresses are user-specific

### Security Rules Content

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is authenticated
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Helper function to check if user owns the resource
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // ===== CATEGORIES =====
    match /categories/{categoryId} {
      allow read: if isAuthenticated();
      allow write: if false;
    }
    
    // ===== PRODUCTS =====
    match /products/{productId} {
      allow read: if isAuthenticated();
      allow write: if false;
    }
    
    // ===== USERS =====
    match /users/{userId} {
      allow read, write: if isOwner(userId);
      
      match /cart/{productId} {
        allow read, write: if isOwner(userId);
      }
      
      match /addresses/{addressId} {
        allow read, write: if isOwner(userId);
      }
      
      match /favorites/{productId} {
        allow read, write: if isOwner(userId);
      }
      
      match /orders/{orderId} {
        allow read: if isOwner(userId);
        allow create: if isOwner(userId) && request.resource.data.userId == userId;
        allow update: if isOwner(userId) && resource.data.userId == userId;
        allow delete: if false;
      }
    }
    
    // ===== ORDERS (Global Collection) =====
    match /orders/{orderId} {
      allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
      allow create: if isAuthenticated() && request.resource.data.userId == request.auth.uid;
      allow update: if isAuthenticated() && resource.data.userId == request.auth.uid;
      allow delete: if false;
    }
  }
}
```

### Deploying Rules

1. **Via Firebase Console:**
   - Go to Firestore Database → Rules tab
   - Copy content from `firestore.rules`
   - Paste into the rules editor
   - Click "Publish"

2. **Via Firebase CLI:**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Deploy rules
firebase deploy --only firestore:rules
```

3. **Via Flutter App:**
   - Rules are automatically enforced by Firestore
   - No additional configuration needed in app

### Testing Rules

1. **Test Mode (Development):**
   - Start in test mode for development
   - Rules allow read/write for 30 days
   - Switch to production rules before deployment

2. **Production Mode:**
   - Deploy security rules from `firestore.rules`
   - Only authenticated users can access data
   - Users can only access their own data

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Firebase project
- Android Studio or Xcode
- Git

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

3. **Configure Firebase** (follow Firebase Setup section above)

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
- Ensure security rules allow write access for seed data

### Address Validation Errors
- Phone must be exactly 10 digits
- Pincode must be exactly 6 digits
- All fields are required

### Products Not Showing in Category Screen
- Verify seed data has been loaded
- Check Firestore collections exist
- Ensure ProductProvider is loading data
- Check security rules allow read access

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
