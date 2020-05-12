//
//  DirectToLoginPage.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-15.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct DirectToLoginPage: View {
    
    @Binding var displayLoginPage: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                NavigationLink(destination: SignInView(isSignUp: true)) {
                    GreenButtonView(buttonTitle: "Sign Up").frame(maxWidth: .infinity)
                }
                
                NavigationLink(destination: SignInView(isSignUp: false)) {
                    GreenButtonView(buttonTitle: "Sign In").frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    self.displayLoginPage.toggle()
                }) {
                    Text("I shall login later").underline().foregroundColor(Color.purple).font(.headline)
                }
                
                Spacer()
                
                
            }.frame(width: 300, height: 300).background(Image("1")).opacity(1)
        }}
}

