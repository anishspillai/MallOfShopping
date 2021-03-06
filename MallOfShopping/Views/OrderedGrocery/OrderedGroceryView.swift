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
    
    @State var displayLoginPage = false
    
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    HStack(alignment: .center) {
                        
                        Text("\(self.orderedItems.totalCost)").font(.headline).padding(.leading)
                        
                        Spacer()
                        
                        EmptyCartButton()
                        
                        CheckoutButton(displayLoginPage: $displayLoginPage).padding(.trailing)
                        
                    }.padding(.top, 10)
                    
                    OrderedGroceryRowView()
                    
                    Spacer()
                    
                }.onAppear(perform: getUser).background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    
                    .navigationBarTitle("Your Order", displayMode: .inline)
                
                if(self.session.session == nil && self.displayLoginPage) {
                    DirectToLoginPage(displayLoginPage: self.$displayLoginPage)
                }
            }
            
        }
        
    }
    
}

struct EmptyCartButton: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    var body: some View {
        Button(action: {
            self.orderedItems.orderedGroceries = []
        }) {
            CommonButtonWithColorInputParameterView(buttonTitle: "Empty orders", isWidthFixed: false, color: Color.red)
        }
    }
    
}

struct CheckoutButton: View {
    
    @EnvironmentObject var session: SessionStore
    @State var selection: Int? = nil
    @Binding var displayLoginPage: Bool
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    
    var body: some View {
        NavigationLink(destination: OrderConfirmationView(), tag: 1, selection: $selection) {
            Button(action: {
                if(self.session.session != nil) {
                    //self.storeOrders()
                    if(!self.orderedItems.orderedGroceries.isEmpty) {
                        self.selection = 1
                    }
                } else {
                    self.displayLoginPage = true
                }
            }) {
                GreenButtonView(buttonTitle: " Check-Out > ", isWidthFixed: false)
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

struct OrderedGroceryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderedGroceryView()
    }
}
