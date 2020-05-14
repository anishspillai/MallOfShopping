//
//  OrderHistoryDetails.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-14.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderHistoryDetails: View {
    
    let orderHistory: OrderHistory
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack{
                
                List {
                    
                    Text(DateConverter.convertToReadableTimeFormat(orderPlacedTimeFormat: self.orderHistory.orderedTime) ).bold()
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .padding()
                    
                    ForEach(self.orderHistory.orders) { order in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text("\(order.groceryName), \(order.type)")
                                    .font(.system(size: 14, weight: .light, design: .serif))
                                    .italic()
                                
                                Text("\(order.noOfItems) * \(order.grossWeight)")
                                    .font(.system(size: 14, weight: .light, design: .serif))
                                    .foregroundColor(.secondary)
                            }.frame(width: geometry.size.width/3, alignment: .topLeading)
                            
                            Divider()
                            
                            Text(order.getPriceWithPrecision())
                            .font(.system(size: 14, weight: .light, design: .serif))
                            .italic()
                            .frame(width: geometry.size.width/3)
                            
                            Divider()
                            
                            Image(systemName: "paperplane.fill").font(.subheadline).foregroundColor(Color.yellow)
                        }
                    }
                    
                    HStack {
                        Text("Total").bold().foregroundColor(Color.red)
                        Spacer()
                        Text("1234 Kr")
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }
        }
    }
}
