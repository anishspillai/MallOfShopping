//
//  OrderedGroceryRowView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderedGroceryRowView: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    func deleteItems(at offsets: IndexSet) {
    }
    
    var body: some View {
        List {
            ForEach(self.orderedItems.orderedGroceries, id: \.id) { orderedGrocery in
                HStack {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(orderedGrocery.groceryName)
                        
                        Text("\(orderedGrocery.noOfItems) * \(orderedGrocery.grossWeight)")
                            .font(.subheadline).foregroundColor(.secondary)
                    }.frame(width: 100)
                    
                    Spacer()
                    
                    HStack {
                        
                        
                        Button(action: {
                            if(orderedGrocery.noOfItems == 1) {
                                
                            } else {
                            }
                        }) {
                            Image(systemName: "minus.circle.fill").imageScale(.medium)
                        }
                        
                        Text(String(orderedGrocery.noOfItems))
                        
                        
                        Button(action: {
                            if(orderedGrocery.noOfItems == 1) {
                                
                            } else {
                            }
                        }) {
                            Image(systemName: "plus.circle.fill").imageScale(.medium)
                        }
                    }
                    
                    Spacer()
                    
                    Text("\(orderedGrocery.getPriceWithPrecision())")
                }
                
            }.onDelete(perform: deleteItems(at:))
        }
    }
}

struct OrderedGroceryRowView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedGroceryRowView()
    }
}
