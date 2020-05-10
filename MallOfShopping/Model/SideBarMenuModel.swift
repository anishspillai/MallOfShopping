//
//  SideBarMenusModel.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-10.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct SideBarMenuModel {
    
    let menu: String
    public var subMenu: [String] = []

    
    init?(snapshot: DataSnapshot) {

        if(!snapshot.hasChildren()) {
            self.menu = snapshot.value as! String
        } else {
            self.menu = snapshot.key 
            self.subMenu = []
            snapshot.children.forEach { subMenu in
                print(subMenu)
                let snapshot: DataSnapshot = subMenu as! DataSnapshot

                self.subMenu.append(snapshot.value as! String)
            }
        }
    }
}
