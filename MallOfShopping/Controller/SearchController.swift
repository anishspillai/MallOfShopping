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
    
    func initialize(sessionStore: SessionStore, isMainPage: Bool) {
        SearchController.shared.sessionStore = sessionStore
        SearchController.shared.isMainPage = isMainPage
    }
    
    func filterGroceryData() {
        
        let filteredGroceryArray: [GROCERY]
        
        if(isMainPage) {
            filteredGroceryArray = self.sessionStore.groceryList.filter{self.searchText.isEmpty ? true : $0.brandName.contains(self.searchText)}
            
            if(!filteredGroceryArray.isEmpty) {
                self.sessionStore.groceryListInGridFormat = filteredGroceryArray.chunked(into: 3)
            } else {
                self.sessionStore.groceryListInGridFormat = [[]]
            }
            
        } else {
            filteredGroceryArray = self.sessionStore.groceryListByType.filter{
                self.searchText.isEmpty ? true : $0.brandName.contains(self.searchText)
            }
            
            if(!filteredGroceryArray.isEmpty) {
                self.sessionStore.groceryListGridByType = filteredGroceryArray.chunked(into: 3)
            } else {
                self.sessionStore.groceryListGridByType = [[]]
            }
        }
        
        
        if(!filteredGroceryArray.isEmpty) {
            self.sessionStore.groceryListInGridFormat = filteredGroceryArray.chunked(into: 3)
        } else {
            self.sessionStore.groceryListInGridFormat = [[]]
        }
    }
    
}
