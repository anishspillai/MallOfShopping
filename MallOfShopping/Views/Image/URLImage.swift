//
//  URLImage.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-17.
//  Copyright © 2020 URV. All rights reserved.
//

import Foundation
import SwiftUI

struct URLImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiImage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiImage).resizable()
        } else {
            return placeholder
        }
    }
    
}
