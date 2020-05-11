//
//  SideBarMenu.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-09.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct SideBarMainPageView: View {
    
    @Binding var displayMenu: Bool
    
    @State private var displayCatagories =  false
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            /**HStack {
             Button(action: {
             withAnimation(.default) {
             self.displayMenu.toggle()
             }
             }) {
             Image(systemName: "heart")
             }
             Spacer()
             }.padding(.top) */
            
            
            NavigationLink(destination: CustomerDetailView()) {
                Text("User Profile").font(.system(size: 15, weight: .light, design: .serif)).padding(.top)
            }
            
            Divider().padding(0)
            
            NavigationLink(destination: CustomerDetailView()) {
                Text("Favorite").font(.system(size: 15, weight: .light, design: .serif))
            }
            
            Divider()
            
            
            Button(action: {
                self.displayCatagories.toggle()
            }) {
                HStack {
                    Text("Catagories").font(.system(size: 15, weight: .light, design: .serif)).padding(0)
                    Image(systemName: "chevron.down")
                }
            }
            
            
            
            if(self.displayCatagories) {
                ForEach(self.session.sideBarMenuModelList, id: \.menu) { sideBarMenuModel in
                    NavigationLink(destination: FilteredGroceryGridView(groceryType: sideBarMenuModel.menu)) {
                        Text(sideBarMenuModel.menu).padding(.leading, 20)
                    }
                }
            }
            
            Spacer()
        }
        .font(.system(size: 15, weight: .light, design: .serif))
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background(Color.gray)
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth:2)
        .shadow(radius: 3).edgesIgnoringSafeArea(.all))
        .opacity(self.displayMenu ? 1: 5)
        .onAppear(perform: fetchSideBarMenuOptions)
        
    }
    
    func fetchSideBarMenuOptions() {
        //self.session.getCatagoriesForSideBarMenu()
    }
}
