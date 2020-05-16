
//
//  CustomerDeliveryAddress.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-12.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct CustomerDeliveryAddress {
    
    let ref: DatabaseReference?
    var apartmentNumber: String
    var address: String
    var firstName: String
    var lastName: String
    var postNumber: String
    var streetName: String
    var telephoneNumber: String
    
    
    
    init(firstName: String,
         lastName: String,
         telephoneNumber: String,
         postNumber: String,
         address: String,
         streetName: String,
         apartmentNumber: String) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.telephoneNumber = telephoneNumber
        self.postNumber = postNumber
        self.address = address
        self.streetName = streetName
        self.apartmentNumber = apartmentNumber
        self.ref = nil
    }
    
    init() {
        self.apartmentNumber = ""
        self.address = ""
        self.firstName = ""
        self.lastName = ""
        self.postNumber = ""
        self.ref = nil
        self.streetName = ""
        self.telephoneNumber = ""
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard
            let value = snapshot.value as? [String: AnyObject],
            let apartmentNumber = value["apartmentNumber"] as? String,
            let address = value["address"] as? String,
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let postNumber = value["postNumber"] as? String,
            let streetName = value["streetName"] as? String,
            let telephoneNumber = value["telephoneNumber"] as? String
            else {
                return nil
            }
        
        self.ref = snapshot.ref
        self.apartmentNumber = apartmentNumber
        self.address = address
        self.firstName = firstName
        self.lastName = lastName
        self.postNumber = postNumber
        self.streetName = streetName
        self.telephoneNumber = telephoneNumber
    }
    
    func toAnyObject() -> Any {
        return [
            "apartmentNumber": apartmentNumber,
            "address": address,
            "firstName": firstName,
            "lastName": lastName,
            "postNumber": postNumber,
            "streetName": streetName,
            "telephoneNumber": telephoneNumber
        ]
    }
    
}
