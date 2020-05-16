//
//  ApartmentNoView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-16.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct ApartmentNoView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var editApartmentNo = false
    
    @State private var apartmentNumber: String  = ""
    
    var body: some View {
        VStack {
            HeaderTextView(headerString: "Apartment No")
            
            HStack {
                
                if(!editApartmentNo) {
                    Text("\(session.customerDeliveryAddress.apartmentNumber)").font(.subheadline).padding(.leading, 25)
                } else {
                    Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("Apartment No", text:  $apartmentNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                
                
                Spacer()
                
                
                
                if(!editApartmentNo) {
                    EditFieldButtonView(editField: $editApartmentNo)
                } else {
                    
                    Button(action: {
                        if(!self.apartmentNumber.isEmpty) {
                            self.session.customerDeliveryAddress.apartmentNumber = self.apartmentNumber
                            self.session.addUserAddress(customerDeliveryAddress: self.session.customerDeliveryAddress)
                            self.editApartmentNo.toggle()
                        }
                    }) {
                        SaveFieldButtonView()
                    }
                    
                    CancelEditFieldButtonView(editField: $editApartmentNo)
                }
            }
            
            Divider()
        }
    }
}
