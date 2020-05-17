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
    var noOfItems: Int
    let price: Float
    let id: String
    let type: String
    let status: String = ""
    
    init(id: String,
         groceryName: String,
         grossWeight: Int,
         noOfItems: Int,
         price: Float,
         type: String) {
        
        self.ref = nil
        self.groceryName = groceryName
        self.grossWeight = grossWeight
        self.noOfItems = noOfItems
        self.id = id
        self.type = type
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
            let type = value["type"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.groceryName = groceryName
        self.grossWeight = grossWeight
        self.noOfItems = noOfItems
        self.id = id
        self.type = type
        self.price = price
    }
    
    func toJsonFormat() -> Any {
        return [
            "groceryName": groceryName,
            "grossWeight": grossWeight,
            "noOfItems": noOfItems,
            "id": id,
            "type": type,
            "price": price
        ]
    }
    
    func getPriceWithPrecision() -> String {
        String(format: "%.2f", self.price) + " Kr"
    }
    
    func getTotalPrice() -> String {
        String(format: "%.2f", (self.price * Float(self.noOfItems)))  + " Kr"
    }
    
    static func getTotalOrderPrice(orders: [ORDERS]) -> String {
        if orders.count > 0 {
            return String(orders.reduce(0) { $0 + (Float($1.noOfItems) * $1.price) })
        } else {
            return "0"
        }
    }
}
