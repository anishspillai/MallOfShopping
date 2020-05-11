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
    
    var totalCost: String {
        if orderedGroceries.count > 0 {
            return String(format: "%.2f", orderedGroceries.reduce(0) { $0 + Float($1.noOfItems) * $1.price})
            
        } else {
            return "0"
        }
    }
    
    func add(item: ORDERS) {
        orderedGroceries.append(item)
    }
    
    func removeGroceryFromTheList(idOfTheItem: String) {
        let indexOfItem = self.orderedGroceries.firstIndex(where: { $0.id == idOfTheItem })
        self.orderedGroceries.remove(at: (indexOfItem!))
    }
    
    func updateOrderCount(idOfTheItem: String, noOfItems: Int) {
        var order: ORDERS! = self.orderedGroceries.first(where: { $0.id == idOfTheItem })
        order.noOfItems = noOfItems
    }
}
