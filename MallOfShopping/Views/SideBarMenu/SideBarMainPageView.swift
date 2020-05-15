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
    
    @State private var selection: Set<String> = []
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 5) {
            Group {
                
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
            }
            
            Group {
                
                ScrollView {
                    if(self.displayCatagories) {
                        ForEach(self.session.sideBarMenuModelList, id: \.menu) { sideBarMenuModel in
                            VStack {
                                if(sideBarMenuModel.subMenu.isEmpty) {
                                    NavigationLink(destination: FilteredGroceryGridView(groceryType: sideBarMenuModel.menu, grocerySubType: "")) {
                                        HStack {
                                            Text(sideBarMenuModel.menu).padding(.leading, 20)
                                            Spacer()
                                        }
                                    }
                                } else {
                                    HStack (spacing: 5) {
                                        Text(sideBarMenuModel.menu).padding(.leading, 20).onTapGesture {
                                            self.selectDeselect(menu: sideBarMenuModel.menu)
                                        }
                                        
                                        Image(systemName: "chevron.down")
                                        
                                        Spacer()
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        if(self.selection.contains(sideBarMenuModel.menu)) {
                                            
                                            ForEach(sideBarMenuModel.subMenu, id: \.self) { subMenu in
                                                NavigationLink(destination: FilteredGroceryGridView(groceryType: sideBarMenuModel.menu, grocerySubType: subMenu)) {
                                                    Text(subMenu)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
                
                Divider()
            }
            
            if(self.session.session == nil) {
                
                HStack {
                    NavigationLink(destination: SignInView()) {
                        GreenButtonView(buttonTitle: "Log In", isWidthFixed: true)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SignInView(isSignUp: true)) {
                        CommonButtonWithColorInputParameterView(buttonTitle: "Sign Up", isWidthFixed: true, color: Color.pink)
                    }
                    
                }
                
            } else {                
                Button(action: {
                    _ = self.session.signOut()
                }) {
                    HStack {
                        GreenButtonView(buttonTitle: "Log Out", isWidthFixed: true)
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
        self.session.getCatagoriesForSideBarMenu()
        self.session.listen()
    }
    
    private func selectDeselect(menu: String) {
        if selection.contains(menu) {
            selection.remove(menu)
        } else {
            selection.insert(menu)
        }
    }
}
