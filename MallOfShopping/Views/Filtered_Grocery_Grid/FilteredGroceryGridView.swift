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
    
    var groceryType: String
    var body: some View {
        VStack {
            if(!session.groceryListGridByType.isEmpty) {
                
                
                GeometryReader { geometry in
                    VStack {
                        TopMenu()
                        
                        if(true) { // Search here
                            
                            ScrollView(showsIndicators: false) {
                                
                                Rectangle()
                                    .frame(width: geometry.size.width, height: 0.01)
                                
                                Spacer()
                                if(true) {
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
                                                
                                                //GroceryView(grocery: grocery)
                                            }
                                        }.padding(.bottom, 5)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
                
                
                
                
            } else {
                Text("Loading...")
            }
            
            Text(String(session.groceryListGridByType.count))
        }
        .onAppear(perform: fetchFilteredGroceries)
    }
    
    func fetchFilteredGroceries() {
        session.getFilteredGroceryList(groceryType: self.groceryType)
    }
}

struct FilteredGroceryGridView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredGroceryGridView(groceryType: "Wheat")
    }
}
