//
//  SearchButton.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct TopMenu: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @EnvironmentObject var sessionStore: SessionStore
    
    
    @State private var displaySearchTextInput: Bool = false
    
    @ObservedObject var tester: SearchController = SearchController.shared
    
    
    var body: some View {
        HStack {
            
            if(!self.displaySearchTextInput) {
                Text("Available items").bold().padding(.leading)
                
                Button(action: {
                    self.displaySearchTextInput.toggle()
                }) {
                    Image(systemName: "magnifyingglass.circle").foregroundColor(Color.orange)
                }
            }
            
            if (self.displaySearchTextInput) {
                ZStack {
                    TextField("Search By brand name", text: self.$tester.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.top).padding(.leading)
                    
                    Button(action: {
                        self.tester.searchText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                    }.offset(x:0, y:0)
                }
            }
            
            Spacer()
            
            Image(systemName: "cart.fill")
                .imageScale(.medium)
                .foregroundColor(.yellow)
            
            Text(self.orderedItems.totalCost)
                .padding(.trailing)
        }.frame(height: 30)
            .onAppear(perform: initializeValuesForSearchController)
    }
    
    func initializeValuesForSearchController() {
        SearchController.shared.setSessionStore(sessionStore: self.sessionStore)
    }
}
