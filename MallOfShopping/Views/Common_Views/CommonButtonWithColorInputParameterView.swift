//
//  CommonButtonWithColorInputParameterView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-15.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct CommonButtonWithColorInputParameterView: View {
    
    let buttonTitle: String
    let isWidthFixed: Bool
    let color: Color
    var body: some View {
        Text(buttonTitle)
            .font(.system(size: 14, weight: .light, design: .serif))
            .italic()
            .frame(width: isWidthFixed ? 100 : 120, height: 30)
            .background(color)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}

struct CommonButtonWithColorInputParameterView_Previews: PreviewProvider {
    static var previews: some View {
        CommonButtonWithColorInputParameterView(buttonTitle: "", isWidthFixed: true, color: Color.red)
    }
}
