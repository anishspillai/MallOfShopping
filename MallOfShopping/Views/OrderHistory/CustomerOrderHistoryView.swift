//
//  CustomerOrderView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-15.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct CustomerOrderHistoryView: View {
    
    @EnvironmentObject var session: SessionStore
    
    
    func getUser () {
        
        session.listen()
        
        session.getOrderHistory()
    }
    
    func deleteItems(at offsets: IndexSet) {
        self.session.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your order status").bold().padding(.top)
                
                if session.session != nil {
                    
                    ForEach(self.session.orderHistories, id: \.self.orderedTime) { orderHistory in
                        OrderHistoryAccordianView(orderHistory: orderHistory)
                    }
                    
                } else {
                    Image(systemName: "person.crop.circle.fill.badge.exclam").font(.largeTitle).padding().foregroundColor(Color.red)
                    Text("Please log in and check the list again").padding()
                }
                Spacer()
                
            }.onAppear(perform: getUser)
                .navigationBarTitle("Your Order History", displayMode: .inline)
        }}
}

struct CustomerOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerOrderHistoryView()
    }
}

struct OrderHistoryAccordianView : View {
    @State private var accordianClickObserver: Bool = false
    let orderHistory: OrderHistory
    var body: some View {
        VStack {
            HStack {
                Text(convertToReadableTimeFormat(orderPlacedTimeFormat: orderHistory.orderedTime))
                Spacer()
                Image(systemName: "chevron.down.square.fill").font(.title)
            }
            .padding(5)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.gray)
            .onTapGesture {
                self.accordianClickObserver.toggle()
            }
            
            if(self.accordianClickObserver) {
                List {
                    ForEach(orderHistory.orders) { order in
                        HStack {
                            VStack(alignment: .leading) {
                                
                                Text("\(order.groceryName), \(order.type)")
                                    .font(.system(size: 14, weight: .light, design: .serif))
                                    .italic()
                                
                                Text("\(order.noOfItems) * \(order.grossWeight)")
                                    .font(.system(size: 14, weight: .light, design: .serif))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text(order.getPriceWithPrecision())
                            
                            Spacer()
                            
                            Image("shipping").resizable().frame(width: 20, height: 20).clipShape(Circle())
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            }

            Divider()
        }
    }
    
    func convertToReadableTimeFormat(orderPlacedTimeFormat: String) -> String {
        return Date(timeIntervalSinceReferenceDate: TimeInterval(Double(String(orderPlacedTimeFormat))!)).description
    }
}
