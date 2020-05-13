//
//  OrderConfirmationView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-11.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State private var displayReciept = false
    
    @State private var showingAlert = false
    
    
    var body: some View {
        //NavigationView {
        
        VStack (){
            VStack {
                Text("Anish")
                Text("Delivry Address").padding()
            }.frame(minWidth:0, maxWidth: .infinity).background(Color.gray)
            
            NavigationLink(destination: CustomerDetailView()) {
                HStack {
                    Text("Delivery Address")
                    Spacer()
                    Text(">").font(.title)
                }.padding().background(Color.orange).border(Color.gray)
            }
            
            
            HStack {
                Text("Reciept")
                Spacer()
                Text(">").font(.title)
            }.padding().background(Color.orange).onTapGesture {
                self.displayReciept.toggle()
            }
            if(self.displayReciept) {
                OrderRecieptView()
            }
            
            /**VStack {
                if(session.orderPlacementStatus == "success") {
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Thank you for the order"), message: Text("Wear sunscreen"))
                    }
                }
            }*/
            
            
            Spacer()
            
            Button(action: {
                self.session.addGroceryForTheUser(orderedItems: self.orderedItems)
                self.showingAlert = true
                
            }) {
                Text("Confirm Order")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(red: 72 / 255, green: 176 / 255, blue: 13 / 255))
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding()
                
            }
                
            .navigationBarTitle("")
        }
        //}
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView()
    }
}
