//
//  User.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-13.
//  Copyright © 2020 URV. All rights reserved.
//

class User {
    
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
