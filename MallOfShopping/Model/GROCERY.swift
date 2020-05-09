//
//  InputGrocery.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-17.
//  Copyright © 2020 URV. All rights reserved.
//
import SwiftUI
import FirebaseDatabase

struct GROCERY: Identifiable  {
    
    var type: String = ""
    var brandName: String = ""
    var Weight: Int = 0
    var unitOfWeight: String = ""
    var actualPrice: Float = 0.0
    var offerPrice: Float  = 0.0
    var id: UUID
    
    
    
    func toAnyObject() -> Any {
        return [
            "type": type,
            "brandName": brandName,
            "Weight": Weight,
            "unitOfWeight": unitOfWeight,
            "actualPrice": actualPrice,
            "offerPrice": offerPrice,
            "id": id
        ]
    }
    
    init(type: String, brandName: String, Weight: Int, unitOfWeight: String, actualPrice: Float, offerPrice: Float, id: UUID) {
        self.type = type
        self.brandName = brandName
        self.Weight = Weight
        self.unitOfWeight = unitOfWeight
        self.actualPrice = actualPrice
        self.offerPrice = offerPrice
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {

        guard
            let value = snapshot.value as? [String: AnyObject],
            let type = value["type"] as? String,
            let brandName = value["brandName"] as? String,
            let Weight = value["Weight"] as? Int,
            let id = value["id"] as? String,
            
            let unitOfWeight = value["unitOfWeight"] as? String,
            let actualPrice = value["actualPrice"] as? Float
            //let offerPrice = value["offerPrice"] as? Float
            else {
                return nil
        }
        

        
        self.type = type
        self.brandName = brandName
        self.Weight = Weight
        self.id = UUID.init(uuidString: id) ?? UUID()
        self.unitOfWeight = unitOfWeight
        self.actualPrice = actualPrice
        if(Weight == 5) {
        self.offerPrice = 50.0
        } else {
            self.offerPrice = 0.0
        }
    }
}
