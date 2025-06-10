//
//  FirebaseFavoritesRepository.swift
//  SoleMate
//
//  Created by Jung H Hwang on 6/9/25.
//


// FirebaseFavoritesRepository.swift
import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseFavoritesRepository: ObservableObject {
    @Published var favorites: [Shoe] = []
    
    private let dbRef = Database.database().reference()
    private var handle: DatabaseHandle?
    
    init() {
        observeFavorites()
    }
    
    private func observeFavorites() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("⚠️ No user logged in, cannot observe favorites")
            return
        }
        let favsRef = dbRef.child("users").child(uid).child("favorites")
        // Listen for any changes under /users/{uid}/favorites
        handle = favsRef.observe(.value) { snapshot in
            var loaded: [Shoe] = []
            for case let child as DataSnapshot in snapshot.children {
                guard
                    let dict = child.value as? [String:Any],
                    let id       = dict["id"] as? Int,
                    let name     = dict["name"] as? String,
                    let acts     = dict["activities"] as? [String],
                    let sizing   = dict["sizingOption"] as? String,
                    let sizeDict = dict["sizeRange"] as? [String:Any],
                    let minL     = sizeDict["minFootLength"] as? Double,
                    let maxL     = sizeDict["maxFootLength"] as? Double,
                    let lUnit    = sizeDict["footLengthUnit"] as? String,
                    let minW     = sizeDict["minFootWidth"] as? Double,
                    let maxW     = sizeDict["maxFootWidth"] as? Double,
                    let wUnit    = sizeDict["footWidthUnit"] as? String,
                    let arch     = dict["archType"] as? String,
                    let price    = dict["price"] as? Double
                else { continue }
                
                let range = SizeRange(
                    minFootLength: minL, maxFootLength: maxL,
                    footLengthUnit: lUnit,
                    minFootWidth: minW, maxFootWidth: maxW,
                    footWidthUnit: wUnit
                )
                
                let shoe = Shoe(
                    id: id,
                    name: name,
                    activities: acts,
                    sizingOption: sizing,
                    sizeRange: range,
                    archType: arch,
                    price: price
                )
                
                loaded.append(shoe)
            }
            DispatchQueue.main.async {
                self.favorites = loaded
            }
        }
    }
    
    func toggleFavorite(_ shoe: Shoe) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("⚠️ No user logged in, cannot modify favorites")
            return
        }
        let favRef = dbRef.child("users").child(uid).child("favorites").child(String(shoe.id))
        if favorites.contains(shoe) {
            // remove from Firebase
            favRef.removeValue()
        } else {
            // push to Firebase
            let payload: [String:Any] = [
                "id": shoe.id,
                "name": shoe.name,
                "activities": shoe.activities,
                "sizingOption": shoe.sizingOption,
                "sizeRange": [
                    "minFootLength": shoe.sizeRange.minFootLength,
                    "maxFootLength": shoe.sizeRange.maxFootLength,
                    "footLengthUnit": shoe.sizeRange.footLengthUnit,
                    "minFootWidth": shoe.sizeRange.minFootWidth,
                    "maxFootWidth": shoe.sizeRange.maxFootWidth,
                    "footWidthUnit": shoe.sizeRange.footWidthUnit
                ],
                "archType": shoe.archType,
                "price": shoe.price
            ]
            favRef.setValue(payload)
        }
    }
    
    deinit {
        if let uid = Auth.auth().currentUser?.uid, let handle = handle {
            dbRef.child("users").child(uid).child("favorites").removeObserver(withHandle: handle)
        }
    }
}
