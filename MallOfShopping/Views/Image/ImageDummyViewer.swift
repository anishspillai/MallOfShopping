//
//  ImageDummyViewer.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-17.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct ImageDummyViewer : View {
    
    let url = "https://mallofshopping.s3.eu-north-1.amazonaws.com/images/Aashirvaad_Wheat.png"
    
    var body: some View {
        
        URLImage(url: url)
        
    }
}
