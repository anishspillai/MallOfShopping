//
//  GreenButtonView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-10.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct GreenButtonView: View {
    
    let buttonTitle: String
    
    let isWidthFixed: Bool
    
    var body: some View {
        
        Text(buttonTitle)
            .font(.system(size: 14, weight: .light, design: .serif))
            .italic()
            .frame(width: isWidthFixed ? 100 : 120, height: 30)
            .background(Color(red: 72 / 255, green: 176 / 255, blue: 13 / 255))
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}

struct GreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GreenButtonView(buttonTitle: "", isWidthFixed: true)
    }
}



