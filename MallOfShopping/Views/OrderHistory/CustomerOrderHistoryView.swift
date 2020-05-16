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
            ScrollView(showsIndicators: false) {
                VStack {
                    
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
            }
        }
    }
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
            
            NavigationLink(destination: OrderHistoryDetails(orderHistory: self.orderHistory)){
                HStack {
                    Text(DateConverter.convertToReadableTimeFormat(orderPlacedTimeFormat: orderHistory.orderedTime))
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                    
                    Spacer()
                    Image(systemName: "chevron.right.circle.fill").foregroundColor(Color.green)
                }.padding(10).cornerRadius(25)
            }
            
            Divider()
        }
    }
}
