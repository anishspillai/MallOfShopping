//
//  FilteredGroceryGridView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-11.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct FilteredGroceryGridView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var searchText = ""
    
    var groceryType: String
    var grocerySubType: String
    
    
    var body: some View {
        VStack {
            
            if(!session.groceryListGridByType.isEmpty) {
                
                GeometryReader { geometry in
                    VStack {
                        
                        TopMenu(isMainPage: false)
                        
                        
                        ScrollView(showsIndicators: false) {
                            
                            Rectangle()
                                .frame(width: geometry.size.width, height: 0.01)
                            
                            Spacer()
                            ForEach(0..<self.session.groceryListGridByType.count, id: \.self) { index in
                                HStack {
                                    ForEach(self.session.groceryListGridByType[index]) { grocery in
                                        
                                        NavigationLink(destination:IndividualGroceryDetailView()) {
                                            
                                            VStack() {
                                                
                                                PriceView(grocery: grocery)
                                                
                                                GroceryDetailView(grocery: grocery)
                                                
                                                GroceryCountStepperView(grocery: grocery)
                                                
                                                Spacer()
                                                
                                            }
                                            .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.orange, lineWidth: 1))
                                            .frame(width: ( geometry.size.width - 50)/3)
                                            .padding(.trailing, 2).padding(.leading, 1)
                                            
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }.padding(.bottom, 5)
                            }
                        }
                    }
                    
                }
                
            } else {
                InitialView()
            }
        }
        .onAppear(perform: fetchFilteredGroceries)
    }
    
    func fetchFilteredGroceries() {
        session.getFilteredGroceryList(groceryType: self.groceryType, grocerySubType: self.grocerySubType)
    }
}

