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
    
    var sessionStore: SessionStore = SessionStore()
    
    func initializeValues(sessionStore: SessionStore, isMainPage: Bool) {
        self.sessionStore = sessionStore
        self.isMainPage = isMainPage
    }
    
    var searchText: String = "" {
        didSet {
            filterGroceryData()
        }
    }
    
    var isMainPage: Bool = true
    
    func filterGroceryData() {
        
        print(self.sessionStore.groceryList)
        
        if(isMainPage) {
            let filteredGroceryArray: [GROCERY] = self.sessionStore.groceryList.filter{$0.brandName.contains(self.searchText)}
            
            print(filteredGroceryArray)
            
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
