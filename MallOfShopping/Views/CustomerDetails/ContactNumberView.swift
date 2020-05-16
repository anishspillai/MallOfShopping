//
//  ContactNumberView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-16.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct ContactNumberView: View {
    
    @State private var editMobileNumber = false
    
    @EnvironmentObject var session: SessionStore
    
    @State private var mobileNumber = ""
    
    
    
    var body: some View {
        
        VStack {
            HeaderTextView(headerString: "Mobile Number")
            
            HStack {
                
                if(!editMobileNumber) {
                    Text(session.customerDeliveryAddress.telephoneNumber).font(.subheadline).padding(.leading,
                                                                                                     25)
                } else {
                    TelephoneNumberInputView(telephoneNumber: $mobileNumber)
                }
                
                Spacer()
                
                if(!editMobileNumber) {
                    
                    EditFieldButtonView(editField: $editMobileNumber)
                    
                } else {
                    
                    Button(action: {
                        if(!self.mobileNumber.isEmpty &&
                            TelephoneNumberValidator.isValidContact(contactNumber: self.mobileNumber)) {
                            
                            self.session.customerDeliveryAddress.telephoneNumber = self.mobileNumber
                            self.session.addUserAddress(customerDeliveryAddress: self.session.customerDeliveryAddress)
                            self.editMobileNumber.toggle()
                            
                        }
                    }) {
                        SaveFieldButtonView()
                    }
                    
                    CancelEditFieldButtonView(editField: $editMobileNumber)
                }
                
            }
            
            Divider()
            
        }
    }
}

struct ContactNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ContactNumberView()
    }
}
