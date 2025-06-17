# RecipeMate

A sleek and modern iOS app built using **SwiftUI**, allowing users to browse, search, and favorite delicious meal recipes. The app leverages the **Food2Fork API** to fetch real-world data and is optimized for clean UI, performance, and local persistence.

---

##  Features

-  **Search Recipes** — Dynamic search bar with instant fetching
-  **View Full Details** — Ingredients, instructions, and publisher
-  **Save to Favorites** — Store and manage your favorite meals locally
-  **Lazy Loading & Pagination** — Seamless infinite scrolling
-  **Image Caching** — Uses `SDWebImageSwiftUI` for fast, efficient loading
-  **SwiftUI UI** — Clean, responsive layout with adaptive fonts

---

##  Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/4089de40-af1c-4360-9965-b430972ffd56" width="200"/>
  <img src="https://github.com/user-attachments/assets/833e8742-f471-4a5a-b45e-ef1b23ceef73" width="200"/>
  <img src="https://github.com/user-attachments/assets/05a4539e-e2cc-4323-b9a6-743a06f3d3ad" width="200"/>
</p>

---

##  Installation Guide

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Rawann0m/RecipeMate.git
   cd MealsRecipesApp
2. **Open in Xcode**
3. **Add API Key to Info.plist**
4. **Build & Run**

   Choose a simulator or real device

   Press Cmd + R to build and run

---

##  Technologies Used

| Tech                 | Description                              |
|----------------------|------------------------------------------|
| **Swift**            | Core programming language                |
| **SwiftUI**          | Declarative UI framework                 |
| **MVVM**             | Clean architecture pattern               |
| **UserDefaults**     | Local persistence for favorites          |
| **SDWebImageSwiftUI**| Efficient image loading and caching      |
| **Food2Fork API**    | External recipe data source              |

   
---

##  Project Structure
```
MealsRecipesApp/
├── Models/
│   ├── Recipe.swift
│   └── RecipeResponse.swift
├── ViewModels/
│   ├── RecipeHomeViewModel.swift
│   └── FavoriteRecipesViewModel.swift
├── Views/
│   ├── RecipeHomeView.swift
│   ├── RecipeDetailsView.swift
│   ├── RecipeCardView.swift
│   └── SearchBarView.swift
├── Extensions/
│   └── ExtensionBundle.swift
├── Assets/
│   └── Images.xcassets
├── Info.plist
└── README.md
```
---

##  Developer

Rawan Majed – iOS Developer & CS Specialist & AI & SwiftUI Enthusiast

🔗 [GitHub](https://github.com/Rawann0m)

💼 [LinkedIn](https://www.linkedin.com/in/rawan-majed0/) 
