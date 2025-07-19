# 🍽️ OneBanc Restaurant App

A native iOS restaurant application built using **Swift (UIKit + SwiftUI)** programmatically (no Storyboards, no third-party libraries), as part of a technical assignment for OneBanc.

---

## 🏗 Features

### 📱 Screens

1. **Home Screen**
   - Horizontally scrollable cuisine cards (infinite scroll)
   - Top 3 rated dishes across all cuisines
   - Cart button with dynamic item count
   - Language switch toggle (Hindi/English)

2. **Cuisine Menu Screen**
   - Displays all dishes under the selected cuisine
   - Add/remove dish quantities

3. **Cart Screen**
   - Group items by cuisine
   - Show net total, tax breakdown (CGST & SGST), and grand total
   - Place order via backend API

---

## 🔧 Tech Stack

- **Swift (5.9+)**
- **SwiftUI + UIKit (Programmatic)**
- No Storyboards
- No third-party libraries
- **URLSession** for networking
- **MVVM** Architecture

---

## 📦 Folder Structure

OneBancRestaurant/

├── Controller/ → ViewModels and Networking

│ ├── CuisineViewModel.swift

│ ├── CartViewModel.swift

│ └── RemoteImage.swift

├── Model/ → Models for API and State

│ ├── Cuisine.swift

│ ├── Dish.swift

│ └── CartItem.swift

├── View/ → SwiftUI Views

│ ├── Home Screen.swift

│ ├── CuisineCardView.swift

│ ├── Menu.swift

│ ├── Cart.swift

│ ├── TopDishes.swift

│ └── CuisineCard.swift

└── OneBancRestaurantApp.swift → Entry point

## 🔌 API Integration

- **GET /get_item_list** – fetches cuisines and dishes
- **POST /make_payment** – sends order details
- Uses headers like:
  - `X-Partner-API-Key`
  - `X-Forward-Proxy-Action`

All networking is handled using `URLSession`.

---

## 🌐 Language Support

- Manual toggle between Hindi & English
- Texts are updated locally on button toggle without restarting app
- Controlled using an `@EnvironmentObject` LanguageViewModel

---

## 🛠 Setup Instructions

1. Clone the repo
2. Open `OneBancRestaurant.xcodeproj`
3. Run in Xcode 15+ (iOS 17 target)
4. No Cocoapods or SPM setup required

---

## ✅ Highlights

- Fully programmatic UI
- Native look & feel
- Grouped cart with quantity controls
- Minimal API calls (fetch once, reuse)
- Error handling and basic logging
- Lightweight and modular design

---

## 🚧 Known Limitations

- No persistent storage (cart resets on app restart)
- Basic language support (manual/local)
- Static placeholder images used if remote image fails

---

## 👤 Author

**Tarasha Bansal**  
Built as part of OneBanc iOS Technical Assignment
