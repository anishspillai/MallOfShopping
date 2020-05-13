//
//  OrderRecieptView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-12.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderRecieptView: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    var body: some View {
        
        ScrollView() {
            VStack {
                Text("Reciept").font(.headline).bold().padding(.bottom)
                
                ForEach(orderedItems.orderedGroceries) { order in
                    Divider()
                    HStack{
                        Text("\(order.noOfItems) * \(order.type),  \(order.groceryName)")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                        Text(order.getTotalPrice())
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .italic()
                    }.padding(.leading).padding(.trailing)
                    
                }
                Divider().accentColor(Color.gray)
                
                HStack {
                    Text("Total").bold()
                    Spacer()
                    Text(orderedItems.totalCost).bold()
                }.padding(.trailing).padding(.leading)
                
                Spacer()
            }
                        
        }
    }
}

struct OrderRecieptView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRecieptView()
    }
}
