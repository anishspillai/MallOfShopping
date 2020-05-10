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
    
    var body: some View {

        Text(buttonTitle)
            .frame(width: 100, height: 30)
            .background(Color(red: 72 / 255, green: 176 / 255, blue: 13 / 255))
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}

struct GreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GreenButtonView(buttonTitle: "")
    }
}
