//
//  SearchButton.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct TopMenu: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    var body: some View {
        HStack {
            Text("    Available items").bold().foregroundColor(Color.black)
            
            Spacer()
            
            Image(systemName: "cart.fill")
                .imageScale(.medium)
                .foregroundColor(.yellow)
            
            Text("\(String(format: "%.2f", self.orderedItems.totalCost)) kr")
                .padding(.trailing)
                .font(.headline)
                .fixedSize()
                .foregroundColor(Color.black)
        }.frame(height: 30)
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        TopMenu()
    }
}
