//
//  OrderView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-13.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var anish = false
    
    func signOut () {
        session.signOut()
    }
    
    func getUser () {
        print("session.session.debugDescription")
        session.listen()
    }
    
    var body: some View {
        /**NavigationView {

        VStack {
                Text("Welcome")
                Text("Hello")
                
                
                Button(action: {
                    print("Delete button tapped!")
                    //if ((self.session.session) != nil) {
                        //Text("Youa are valid")
                    //} else {
                    self.anish = true
                    //}
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }

           
           Button(action: signOut) {
                              Text("Sign Out")
                          }
            
            
            if(self.anish && self.session.session == nil) {
            
                   
                       /** NavigationLink(destination: SignInView()) {
                            Button(action: { self.anish.toggle() }) {
                                Text("Show 🐢")
                            }.sheet(isPresented: $anish) {
                                Button(action: self.signOut) {
                                    self.anish = false
                                }
                            }
                        }.navigationBarTitle("Navigation") */
                    
                }
                
                
                
            }
        }.onAppear(perform: getUser)*/
        
        
      
                Text("Welcome")
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
