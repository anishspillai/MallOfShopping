//
//  DirectToLoginPage.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-15.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct DirectToLoginPage: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                NavigationLink(destination: SignInView(isSignUp: true)) {
                    Text("Sign Up")
                }
                
                NavigationLink(destination: SignInView(isSignUp: false)) {
                    Text("Sign In")
                }
            }.frame(width: 300, height: 300).background(Image("1")).opacity(0.5)
        }}
}

struct DirectToLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        DirectToLoginPage()
    }
}
