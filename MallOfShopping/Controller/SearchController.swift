//
//  SearchController.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-11.
//  Copyright © 2020 URV. All rights reserved.
//

import Combine
import SwiftUI

class SearchController: ObservableObject {
    
    static let shared = SearchController()
    
    var sessionStore: SessionStore = SessionStore()
    
    @Published var isMainPage: Bool = false
    
    var searchText: String = "" {
        didSet {
            filterGroceryData()
        }
    }
    
    private init() {
    }
    
    func setSessionStore(sessionStore: SessionStore) {
        SearchController.shared.sessionStore = sessionStore
        SearchController.shared.isMainPage = true
    }
    
    func filterGroceryData() {
        
        if(true) {
            let filteredGroceryArray: [GROCERY] = self.sessionStore.groceryList.filter{self.searchText.isEmpty ? true : $0.brandName.contains(self.searchText)}
            
            if(!filteredGroceryArray.isEmpty) {
                self.sessionStore.anish = filteredGroceryArray.chunked(into: 3)
            } else {
                 self.sessionStore.anish = [[]]
            }
        } else {
            let filteredGroceryArray: [GROCERY] = self.sessionStore.groceryListByType.filter{$0.brandName.localizedStandardContains(self.searchText)}
            self.sessionStore.groceryListGridByType = filteredGroceryArray.chunked(into: 3)
        }
    }

}
