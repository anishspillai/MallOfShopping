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
            VStack(alignment: .center, spacing: 20) {
                
                Spacer()
                
                NavigationLink(destination: SignInView(isSignUp: true)) {
                    GreenButtonView(buttonTitle: "Sign Up", isWidthFixed: true).frame(maxWidth: .infinity)
                }
                
                NavigationLink(destination: SignInView(isSignUp: false)) {
                    GreenButtonView(buttonTitle: "Sign In", isWidthFixed: true).frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    self.displayLoginPage.toggle()
                }) {
                    Text("I shall login later")
                        .font(.system(size: 18, weight: .light, design: .serif))
                        .italic()
                        .underline()
                        .foregroundColor(Color.purple)
                        .font(.headline)
                }
                
                Spacer()
                
            }.background(Image("1").resizable().opacity(0.2))
        }}
}

