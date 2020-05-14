//
//  DateConverter.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-15.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

class DateConverter {
    
   static func convertToReadableTimeFormat(orderPlacedTimeFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(Double(String(orderPlacedTimeFormat))!))
        return formatter.string(from: date)
    }
}
