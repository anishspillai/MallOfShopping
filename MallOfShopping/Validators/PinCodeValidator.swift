//
//  PinCodeValidator.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-13.
//  Copyright © 2020 URV. All rights reserved.
//
import SwiftUI

class PinCodeValidator {
        
    static func isValidPinNumber(pinNumber: String) -> Bool {
        if(pinNumber.isEmpty){
            return true
        }
        let pinCodeRegex = "\\d{5}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", pinCodeRegex)
        return phoneTest.evaluate(with: pinNumber)
    }
}
