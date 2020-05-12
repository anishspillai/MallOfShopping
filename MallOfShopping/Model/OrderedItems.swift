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
    
    var total: Int {
        if orderedGroceries.count > 0 {
            return orderedGroceries.reduce(0) { $0 + $1.noOfItems }
        } else {
            return 0 
        }
    }
    
    var totalCost: String {
        if (!orderedGroceries.isEmpty) {
            //return "\(orderedGroceries.reduce(0) { $0 + Float($1.noOfItems) * $1.price}) Kr"
            return String(format: "%.2f", orderedGroceries.reduce(0) { $0 + Float($1.noOfItems) * $1.price}) + " Kr"
            
        } else {
            return "0 Kr"
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
        let indexOfItem: Int = self.orderedGroceries.firstIndex(where: { $0.id == idOfTheItem })!
        self.orderedGroceries[indexOfItem].noOfItems = noOfItems
    }
    
    func increament(idOfTheItem: String) {
        let indexOfItem: Int = self.orderedGroceries.firstIndex(where: { $0.id == idOfTheItem })!
        self.orderedGroceries[indexOfItem].noOfItems += 1
    }
    
    func decrement(idOfTheItem: String) {
        let indexOfItem: Int = self.orderedGroceries.firstIndex(where: { $0.id == idOfTheItem })!
        if(self.orderedGroceries[indexOfItem].noOfItems == 1) {
            self.orderedGroceries.remove(at: (indexOfItem))
        } else {
            self.orderedGroceries[indexOfItem].noOfItems -= 1
        }
    }
}
