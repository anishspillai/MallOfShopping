//
//  SideBarMenu.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-09.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct SideBarMenu: View {
    
    @Binding var displayMenu: Bool

    var body: some View {
        
        VStack{
            HStack {
                Button(action: {
                    withAnimation(.default) {
                        self.displayMenu.toggle()
                    }
                }) {
                    Image(systemName: "heart")
                }
            }.padding(.top)
                .padding(.bottom, 25)
            
            Spacer()
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background(Color.gray).edgesIgnoringSafeArea(.all)
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth:2)
        .shadow(radius: 3).edgesIgnoringSafeArea(.all))
        .opacity(self.displayMenu ? 1: 5)
    }
}

