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
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text(orderedGrocery.groceryName).font(.subheadline)
                            
                            Text("\(orderedGrocery.noOfItems) * \(orderedGrocery.grossWeight)")
                                .font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer()
                    }.frame(width: 100)
                    
                    Spacer()
                    
                    
                    Divider()
                    
                    HStack {
                        
                        
                        Button(action: {

                            
                            if(orderedGrocery.noOfItems == 1) {
                                self.orderedItems.removeGroceryFromTheList(idOfTheItem: orderedGrocery.id)
                            } else {
                                //orderedGrocery.noOfItems -= 1
                            }
                            
                        }) {
                            Image(systemName: "minus.circle.fill").imageScale(.medium).foregroundColor(Color.orange)
                        }
                        
                        Text(String(orderedGrocery.noOfItems))
                        
                        
                        Button(action: {

                            //orderedGrocery.noOfItems += 1
                        }) {
                            Image(systemName: "plus.circle.fill").imageScale(.medium).foregroundColor(Color.orange)
                        }
                    }.buttonStyle(PlainButtonStyle())
                    
                    Divider()
                    
                    Text("\(orderedGrocery.getPriceWithPrecision())").font(.subheadline)
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
