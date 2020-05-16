//
//  AddressView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-16.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @State private var editAddress = false
    
    @EnvironmentObject var session: SessionStore
    
    @State private var streetName: String = ""
    
    @State private var address: String = ""
    
    
    var body: some View {
        VStack {
            
            HStack {
                HeaderTextView(headerString: "Address")
                
                Spacer()
                
                if(!editAddress) {
                    EditFieldButtonView(editField: $editAddress)
                } else {
                    
                    Button(action: {
                        if(!self.streetName.isEmpty && !self.address.isEmpty) {
                            
                            self.session.customerDeliveryAddress.streetName = self.streetName
                            self.session.customerDeliveryAddress.address = self.address
                            
                            self.session.addUserAddress(customerDeliveryAddress: self.session.customerDeliveryAddress)
                            self.editAddress.toggle()
                        }
                    }) {
                        SaveFieldButtonView()
                    }
                    
                    CancelEditFieldButtonView(editField: $editAddress)
                }
                
            }
            
            if(!editAddress) {
                Text("\(session.customerDeliveryAddress.streetName), \(session.customerDeliveryAddress.address)")
            } else {
                VStack {
                    TextField("Street Name", text:  $streetName)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                    
                    TextField("Address", text:  $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
            }
            
            Divider()
        }
    }
}
