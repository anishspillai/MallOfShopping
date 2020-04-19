//
//  OrderedGroceryView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderedGroceryView: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State var anish = false
    @State var quantity = 0
    @State var displayLoginPage = false
    
    @EnvironmentObject var session: SessionStore
    
    
    
    
    
    func storeOrders() {
        session.addGroceryForTheUser(orders: self.orderedItems.orderedGroceries)
    }
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                HStack(alignment: .center) {
                    
                    //CartImage()
                    Text("\(self.orderedItems.total)").font(.headline).foregroundColor(Color.black)
                    
                    Spacer()
                    
                    EmptyCartButton()
                    
                    CheckoutButton(displayLoginPage: $displayLoginPage)
                    
                    Spacer()
                    
                    SignoutButton()
                    
                }.padding(.top, 10)
                
                ZStack {
                    OrderedGroceryRowView()
                    
                    if(self.session.session == nil && self.displayLoginPage) {
                        DirectToLoginPage()
                    }
                }
                
                Spacer()
            }.onAppear(perform: getUser).background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
            
            //.navigationBarHidden(true)
            .navigationBarTitle("Your Order", displayMode: .inline)
        }
    }
    
    
}

struct EmptyCartButton: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    var body: some View {
        Button(action: {
            self.orderedItems.orderedGroceries = []
        }) {
            Text("Empty Cart")
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20).padding(.trailing, 10).padding(.leading, 10)
        }
    }
    
}

struct CheckoutButton: View {
    
    @EnvironmentObject var session: SessionStore
    @State var selection: Int? = nil
    @Binding var displayLoginPage: Bool
    
    
    var body: some View {
        NavigationLink(destination: CustomerDetailsView(), tag: 1, selection: $selection) {
            Button(action: {
                if(self.session.session != nil) {
                    //self.storeOrders()
                    self.selection = 1
                } else {
                    self.displayLoginPage = true
                    
                    
                }
            }) {
                
                Text("Check out")
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange ]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20).padding(.trailing, 10).padding(.leading, 10)
            }
        }
    }
}

struct CartImage: View {
    var body: some View {
        Image(systemName: "cart.fill")
            .imageScale(.medium)
            .foregroundColor(.yellow).padding(.leading, 5)
    }
}

struct SignoutButton: View {
    var body: some View {
        Button(action: {
            self.signOut()
        }) {
            Image(systemName: "cloud.fill")
        }
    }
    func signOut () {
        //self.displayLoginPage = false
        //session.signOut()
    }
}


struct OrderedGroceryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedGroceryView()
    }
}
