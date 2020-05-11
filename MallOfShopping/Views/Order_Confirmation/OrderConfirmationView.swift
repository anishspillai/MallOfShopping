//
//  OrderConfirmationView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-11.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct OrderConfirmationView: View {
    var body: some View {
        //NavigationView {
        
        VStack (){
            VStack {
                Text("Anish")
                Text("Delivry Address").padding()
            }.frame(minWidth:0, maxWidth: .infinity).background(Color.gray)
            
            NavigationLink(destination: CustomerDetailView()) {
                HStack {
                    Text("Delivery Address")
                    Spacer()
                    Text(">").font(.title)
                }.padding().background(Color.orange).border(Color.gray)
            }
            
            NavigationLink(destination: CustomerDetailView()) {
                HStack {
                    Text("Reciept")
                    Spacer()
                    Text(">").font(.title)
                }.padding().background(Color.orange)
            }
            
            Spacer()
            
            GreenButtonView(buttonTitle: "Finish").padding()
                
                .navigationBarTitle("")
        }
        //}
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView()
    }
}
