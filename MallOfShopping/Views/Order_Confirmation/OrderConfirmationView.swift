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
    
    @EnvironmentObject var favorite: Favorite
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State private var displayReciept = false
    
    @State private var showAlert = false
    
    var body: some View {
        //NavigationView {
        
        VStack {
            
            Text("We deliver everyday between 6:30 to 9:30 PM").font(.subheadline).padding()
                .frame(minWidth:0, maxWidth: .infinity).background(Color.gray)
            
            NavigationLink(destination: CustomerDetailView()) {
                HStack {
                    Text("Delivery Address").font(.system(size: 14, weight: .light, design: .serif))
                    Spacer()
                    Image(systemName: "chevron.right.circle.fill").font(.title).font(.system(size: 14, weight: .light, design: .serif)).foregroundColor(Color.green)
                }.padding().foregroundColor(Color.gray)
            }
            
            
            if(session.customerDeliveryAddress.postNumber.isEmpty) {
                Text("Delivery address is missing. Please provide address for placing orders")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(Color.red)
            }
            Divider()
            
            HStack {
                
                Text("Reciept").font(.system(size: 14, weight: .light, design: .serif))
                Spacer()
                Image(systemName: "chevron.down.circle.fill").font(.title).font(.system(size: 14, weight: .light, design: .serif)).foregroundColor(Color.green)
                
            }.padding().onTapGesture {
                self.displayReciept.toggle()
            }.foregroundColor(Color.gray)
            
            if(self.displayReciept) {
                OrderRecieptView()
            }
            
            Divider()
            Spacer()
            
            Button(action: {
                
                self.session.addGroceryForTheUser(orderedItems: self.orderedItems)
                
                if(!self.favorite.items.isEmpty) {
                    self.session.addFavoriteGroceries(favorites: self.favorite.items)
                }
                self.showAlert = true
                
            }) {
                Text("Confirm Order")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color(red: 72 / 255, green: 176 / 255, blue: 13 / 255))
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding()
                
            }
            .disabled(session.customerDeliveryAddress.postNumber.isEmpty ? true : false)
                
            .navigationBarTitle("")
        }.onAppear(perform: fetchUserDetails)
            
            
            .alert(isPresented: $showAlert) {
                switch session.orderPlacementStatus {
                case "success":
                    return Alert(title: Text("Thanks!").foregroundColor(Color.green).bold(), message: Text("Your order has been succesfully placed!"))
                    
                case "failed":
                    return Alert(title: Text("Sorry!").foregroundColor(Color.red).bold(), message: Text("Something goes wrong. Please contact 0123456789 or use the web application!!!"))
                    
                default:
                    return Alert(title: Text("Sorry!"), message: Text("Not able to get the status of order placement. Please check the order history tab"))
                }
        }
    }
    
    
    func fetchUserDetails() {
        session.listen()
        self.session.fetchUserDeliveryAddress()
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView()
    }
}
