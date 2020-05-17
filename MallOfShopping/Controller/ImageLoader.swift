//
//  ImageLoader.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-17.
//  Copyright © 2020 URV. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func load(url: String) {
        
        guard let imageURL = URL(string: url) else {
            fatalError("ImageURL is not correct!")
        }
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.downloadedImage = UIImage(data: data)
                self.didChange.send(self)
            }
        }
        task.resume()
    }    
    
}
