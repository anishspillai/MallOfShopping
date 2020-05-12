//
//  OrderRecieptView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-12.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderRecieptView: View {

    @EnvironmentObject var orderedItems: OrderedItems

    var body: some View {
        
        VStack {
            ForEach(orderedItems.orderedGroceries) { order in
                Text(order.groceryName)
            }
        }
        
        
        
    }
}

struct OrderRecieptView_Previews: PreviewProvider {
    static var previews: some View {
        OrderRecieptView()
    }
}
