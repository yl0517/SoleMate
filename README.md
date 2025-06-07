# SoleMate – The Right Fit for Your Feet

SoleMate is a personalized footwear recommendation app that helps users find shoes based on their unique foot shape, activity needs, and budget. It also allows users to view and contribute discussion posts related to specific shoes to improve awareness of fit and long-term health impact.

"The right fit for your feet, the right step for your health."

---

## Features

- Input foot measurements and activity type  
- Get matched with suitable shoes across brands  
- Filter shoes by price range  
- View health-related shoe information  
- Save shoe recommendations to profile  
- Create and view discussions for specific shoes  
- Get notifications for price changes (optional)  

---

## Tech Stack

| Layer        | Tools Used                            |
|--------------|----------------------------------------|
| Language     | Swift                                  |
| Framework    | SwiftUI + UIKit                        |
| Database     | Firebase Firestore (for discussions)   |
| Local Data   | JSON file (shoe catalog)               |
| Auth (optional) | Firebase Auth                       |

---

## Folder Structure

```
SoleMate/
├── Models/
│   ├── Shoe.swift
│   └── DiscussionPost.swift
├── Views/
│   ├── ShoeListView.swift
│   ├── ShoeDetailView.swift
│   └── DiscussionView.swift
├── Services/
│   ├── FirebaseManager.swift
│   └── ShoeDataLoader.swift
├── Resources/
│   └── shoes.json
├── GoogleService-Info.plist
├── README.md
└── SoleMateApp.swift
```

---

## Setup Instructions

### 1. Clone the Repo

```bash
git clone https://github.com/your-team/solemate.git
cd solemate
```

### 2. Open in Xcode

Open `SoleMate.xcodeproj` or `SoleMate.xcworkspace`.

### 3. Install Firebase SDK

Use Swift Package Manager:

```
https://github.com/firebase/firebase-ios-sdk
```

Add:
- FirebaseFirestore  
- FirebaseAuth 

### 4. Add Firebase Config File

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a Firebase project and add your iOS app  
3. Download `GoogleService-Info.plist`  
4. Drag it into the root of your Xcode project  

### 5. Load Static Shoe Catalog

Place `shoes.json` in the `Resources/` folder, and load it at launch using:

```swift
ShoeDataLoader.loadShoesIfNeeded()
```

### 6. Firestore Rules for Prototyping

```js
service cloud.firestore {
  match /databases/{database}/documents {
    match /posts/{post} {
      allow read, write: if true;
    }
  }
}
```

---

## Key Screens

- Shoe List – View all matched shoes  
- Shoe Detail – See fit info, reviews, and start a discussion  
- Discussion – Post and reply to comments  
- Settings/Profile – (optional) Save preferences  

---

## Contributors

- Jia Wu  
- Carlos Alexis Carrillo-Sandoval  
- Ray Hwang  
- Yoobin Lee  

---

## License

This project is for academic use only and not licensed for commercial distribution.
