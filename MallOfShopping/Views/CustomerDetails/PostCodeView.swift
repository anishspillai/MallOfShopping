//
//  PostCodeView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-16.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct PostCodeView: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State private var editPostalCode = false
    
    @State private var postalCode: String = ""
    
    var body: some View {
        VStack {
            HeaderTextView(headerString: "Postal Code")
            
            HStack {
                
                if(!editPostalCode) {                Text("\(session.customerDeliveryAddress.postNumber)").font(.subheadline)
                } else {
                    PinCodeInputView(pinCode: $postalCode)
                }
                                
                Spacer()
                              
                
                if(!editPostalCode) {
                    EditFieldButtonView(editField: $editPostalCode)
                } else {
                    
                    Button(action: {
                        if(!self.postalCode.isEmpty) {
                            self.session.customerDeliveryAddress.postNumber = self.postalCode
                            self.session.addUserAddress(customerDeliveryAddress: self.session.customerDeliveryAddress)
                            self.editPostalCode.toggle()
                        }
                    }) {
                        SaveFieldButtonView()
                    }
                    
                    CancelEditFieldButtonView(editField: $editPostalCode)
                }
            }.padding(.leading, 25)
        }
    }
}

struct PostCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PostCodeView()
    }
}
