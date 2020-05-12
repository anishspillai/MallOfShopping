//
//  GroceryArrangerByType.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-12.
//  Copyright © 2020 URV. All rights reserved.
//

struct GroceryArrangerByType {
    static func groupByGroceryType(orders: [ORDERS]) -> Dictionary<String, [ORDERS]> {
        return Dictionary(grouping: orders) { $0.type }
    }
}
