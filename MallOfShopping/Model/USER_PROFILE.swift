//
//  USER_PROFILE.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-19.
//  Copyright © 2020 URV. All rights reserved.
//


struct USERPROFILE  {
    
    var firstname: String
    var lastname: String
    var telephoneNumber: String
    var postNumber: String
    var city: String
    var streetName: String
    var apartmentNumber: String
    
    
    
    func toAnyObject() -> Any {
        return [
            "firstname": firstname,
            "lastname": lastname,
            "telephoneNumber": telephoneNumber,
            "postNumber": postNumber,
            "city": city,
            "streetName": streetName,
            "apartmentNumber": apartmentNumber
        ]
    }
    
    init(firstname: String,
         lastname: String,
         telephoneNumber: String,
         postNumber: String,
         city: String,
         streetName: String,
         apartmentNumber: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.telephoneNumber = telephoneNumber
        self.postNumber = postNumber
        self.city = city
        self.streetName = streetName
        self.apartmentNumber = apartmentNumber
    }
}
