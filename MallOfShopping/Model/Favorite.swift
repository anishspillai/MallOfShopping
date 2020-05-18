//
//  Favorite.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-18.
//  Copyright © 2020 URV. All rights reserved.
//


import SwiftUI
import Firebase
import Combine

class Favorite: ObservableObject {
    
    @Published var items = [String]()
    
    @Published var favoriteGroceries: [[GROCERY]] = [[]]
    
    func favoriteClickHandler(groceryId: String) {
        if(self.items.contains(groceryId)) {
            self.items.remove(at: self.items.firstIndex(of: groceryId)!)
        } else {
            self.items.append(groceryId)
        }
    }
    
    func getFavorites() {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/favorites/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let favorite: String = snapshot.value as? String {
                    self.items.append(favorite)
                }
            }
        }
    }
    
    func fetchFavoriteGroceries(groceryList: [GROCERY]) {
        var filteredGroceryArray: [GROCERY]
        if(!self.items.isEmpty ) {
            
            /**ForEach(self.items) {_ in
            
            filteredGroceryArray = groceryList.filter{$0.id.uuidString.contains("")}
            
            }*/
            
        }
    }
     
    
}
