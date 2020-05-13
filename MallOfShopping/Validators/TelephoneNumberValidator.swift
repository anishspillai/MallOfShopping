//
//  TelephoneNumberValidator.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-13.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

class TelephoneNumberValidator {
    
    static func isValidContact(contactNumber: String) -> Bool {
        if(contactNumber.isEmpty) {
            return true
        }
            let phoneNumberRegex = "^[0]\\d{9}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
            let isValidPhone = phoneTest.evaluate(with: contactNumber)
            return isValidPhone
        }
}
