//
//  AppView.swift
//  Mall of Shopping
//
//  Created by Anish Pillai on 2020-03-24.
//  Copyright © 2020 Anish. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var orderedItems: OrderedItems
    
    private var tabsCount: CGFloat = 3
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                // TabView
                TabView {
                    IndividualGrocery()
                        .tabItem {
                            Image(systemName: "list.dash")
                            Text("Menu")
                    }
                    
                    OrderedGroceryView() // Test
                        .tabItem {
                            Image(systemName: "cart.fill")
                            Text("Orders")
                    }
                    
                    CustomerOrderHistoryView()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Order History")
                    }
                    
                    /**ElseTest()
                        .tabItem {
                            Image(systemName: "indianrupeesign.circle")
                            Text("Offers")*/
                    //}
                }
                
                // Badge View
                ZStack {
                    Circle()
                        .foregroundColor(.red)
                    
                    Text("\(self.orderedItems.total)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 10))
                }
                .frame(width: 25, height: 25)
                    //.offset(x: ( ( 2 * self.badgePosition) - 2 ) * ( geometry.size.width / ( 2 * self.tabsCount ) ), y: -30)
                    .offset(x: 190, y: -30)
                    .opacity(self.orderedItems.total == 0 ? 0 : 3)

            }

            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppView()
    }
}
