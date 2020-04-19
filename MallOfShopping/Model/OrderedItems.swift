//
//  OrderedItems.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-13.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI
import Combine

final class OrderedItems: ObservableObject {
    @Published var orderedGroceries = [ORDERS]()
    
     var total: Float {
           if orderedGroceries.count > 0 {
            return orderedGroceries.reduce(0) { $0 + Float($1.noOfItems) }
           } else {
               return 0
           }
       }
       
        var totalCost: Float {
              if orderedGroceries.count > 0 {
                return orderedGroceries.reduce(0) { $0 + Float($1.noOfItems) * $1.price}
              } else {
                  return 0
              }
          }
    
    func add(item: ORDERS) {
        orderedGroceries.append(item)
    }
}

/**struct OrderedGrocery: Identifiable {
    var noOfItems: Int
    var id = UUID()
    var name: String
    var price: Float
    var grossWeight: Int
    
    init(id: UUID, noOfItems: Float, name: String, price: Float, grossWeight: Int) {
        self.id = id
        self.noOfItems = noOfItems
        self.name = name
        self.price = price
        self.grossWeight = grossWeight
    }
    
    func getPriceWithPrecision() -> String {
        String(format: "%.2f", self.price)
    }
    
}*/
