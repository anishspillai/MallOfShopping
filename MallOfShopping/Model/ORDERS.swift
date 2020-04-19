//
//  TODOS.swift
//  TODO
//
//  Created by Sebastian Esser on 9/18/19.
//  Copyright © 2019 Sebastian Esser. All rights reserved.
//
import SwiftUI
import FirebaseDatabase

struct ORDERS: Identifiable {
    
    let ref: DatabaseReference?
    let groceryName: String
    let grossWeight: Int
    let noOfItems: Int
    let price: Float
    let id: String
    let timeOfOrder: String
    
    init(id: String, groceryName: String, grossWeight: Int, noOfItems: Int, price: Float, timeOfOrder: String) {
        self.ref = nil
        self.groceryName = groceryName
        self.grossWeight = grossWeight
        self.noOfItems = noOfItems
        self.id = id
        self.timeOfOrder = timeOfOrder
        self.price = price
        
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let value = snapshot.value as? [String: AnyObject],
            let groceryName = value["groceryName"] as? String,
            let grossWeight = value["grossWeight"] as? Int,
            let noOfItems = value["noOfItems"] as? Int,
            let price = value["price"] as? Float,
            let id = value["id"] as? String,
            let timeOfOrder = value["timeOfOrder"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.groceryName = groceryName
        self.grossWeight = grossWeight
        self.noOfItems = noOfItems
        self.id = id
        self.timeOfOrder = timeOfOrder
        self.price = price
    }
    
    func toJsonFormat() -> Any {
        return [
            "groceryName": groceryName,
            "grossWeight": grossWeight,
            "noOfItems": noOfItems,
            "id": id,
            "timeOfOrder": timeOfOrder,
            "price": price
        ]
    }
    
    func getPriceWithPrecision() -> String {
        String(format: "%.2f", self.price)
    }
}
