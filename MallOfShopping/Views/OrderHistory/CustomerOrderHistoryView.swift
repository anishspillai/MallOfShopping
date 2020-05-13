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
        
        print(session.orderHistories)
        session.listen()
        
        session.getOrderHistory()
        print(session.orderHistories)
    }
    
    func deleteItems(at offsets: IndexSet) {
        self.session.orders.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
        VStack {
            Text("Your order status").bold().padding(.top).padding(.bottom)
            
            Spacer()
            
                if session.session != nil {
                    List {
                        ForEach(self.session.orders) { ORDERS in
                            HStack {
                                VStack {
                                    Text("\(ORDERS.noOfItems) * \(ORDERS.groceryName)").font(.headline)
                                    Text("\(ORDERS.grossWeight)")
                                }.padding(.leading, 5)
                                
                                Spacer()
                                
                                Image("shipping").resizable().frame(width: 50, height: 50).clipShape(Circle())
                            }.background(Color.orange).cornerRadius(10).padding(.trailing, 10)
                        }.onDelete(perform: deleteItems(at:))
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
