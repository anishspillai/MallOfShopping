//
//   ItemDetail.swift
//  iDine
//
//  Created by Anish Pillai on 2020-03-24.
//  Copyright © 2020 Anish. All rights reserved.
//

import SwiftUI

struct IndividualGroceryDetailView: View {
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State var anish = false
    
    @State var quantity = 0
    
    
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .leading, spacing: 0) {
                
                Image("21")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 30, height:200 )
                
            }.background(Color.white)
                .cornerRadius(25)
                .padding(.top)
            
            ScrollView {
                Text("Many people believe that kale, spinach, and other such things can detox their body, and if that's you we're happy to take your money from you with this salad.").padding()
            }
            
            if !self.anish {
                Button("Köp") {
                    self.anish = true
                    self.quantity += 1
                    //self.order.add(item: self.item)
                }
                .font(.headline)
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
            
            if self.anish {
                
                HStack {
                    
                    Button(action: {
                        if(self.quantity > 0){
                            self.quantity -= 1
                        }
                    }) {
                        Text("-")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(Color.black)
                            .clipShape(Circle())
                            .foregroundColor(.white).padding(.trailing)
                    }
                    
                    Text(String(self.quantity))
                    
                    
                    Button(action: {
                        self.quantity += 1
                    }) {
                        Text("+")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(Color.green)
                            .clipShape(Circle())
                            .foregroundColor(.white).padding(.leading)
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("Anish", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                //self.favorite.add(item: self.item)
            }) {
                Image(systemName: "heart.fill").imageScale(.large)
            }
        )
    }
    
    
}



struct ItemDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            IndividualGroceryDetailView()
        }
    }
}
