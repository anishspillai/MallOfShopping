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
            
            VStack {
                
                Spacer()
                
                VStack (alignment: .leading) {
                    
                    Text("Icon Defenition")
                        .font(.system(size: 18, weight: .light, design: .serif)).padding(.leading, 40)
                    Divider()
                    
                    HStack {
                        
                        Image(systemName: "xmark.seal.fill").foregroundColor(Color.red).font(.subheadline)
                        Text("Not yet packed").font(.system(size: 12, weight: .light, design: .serif))
                            .padding()
                        
                        Image(systemName: "paperplane.fill").foregroundColor(Color.yellow).font(.subheadline)
                        Text("On the way").font(.system(size: 12, weight: .light, design: .serif))
                            .padding()
                        
                        Image(systemName: "checkmark.seal.fill").foregroundColor(Color.green).font(.subheadline)
                        Text("Delivered").font(.system(size: 12, weight: .light, design: .serif))
                            .padding()
                    }.padding(.leading).padding(.trailing)
                }
                .padding(.top)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.yellow, lineWidth: 1)
                )
                
                
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
                            
                            Image(systemName: self.getIcon(status: order.status))
                                .font(.subheadline)
                                .foregroundColor(self.getIconColor(status: order.status))
                        }
                    }
                    
                    HStack {
                        
                        Text("Total").bold().foregroundColor(Color.red)
                        
                        Spacer()
                        
                        Text(ORDERS.getTotalOrderPrice(orders: self.orderHistory.orders))
                            .font(.system(size: 14, weight: .light, design: .serif))
                            .italic()
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }
        }
    }
    
    func getIcon(status: String) -> String {
        switch status {
            
        case "shipped":
            return "paperplane.fill"
            
        case "delivered":
            return  "checkmark.seal.fill"
            
        default:
            return "xmark.seal.fill"
        }
    }
    
    func getIconColor(status: String) -> Color {
        switch status {
            
        case "shipped":
            return Color.yellow
            
        case "delivered":
            return  Color.green
            
        default:
            return Color.red
        }
    }
}
