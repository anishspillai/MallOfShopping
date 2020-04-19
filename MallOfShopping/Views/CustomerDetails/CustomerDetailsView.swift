//
//  CustomerDetailsView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-19.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct CustomerDetailsView: View {
    
    @EnvironmentObject var session: SessionStore
    
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var telephoneNumber: String = ""
    
    @State private var postNumber: String = ""
    @State private var city: String = ""
    @State private var streetName: String = ""
    @State private var apartmentNumber: String = ""
    
    
    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("User Details")) {
                    TextField("Firstname",
                              text: $firstname)
                    
                    TextField("Lastname",
                              text: $lastname)
                    
                    TextField("Mobile Number",
                              text: $telephoneNumber)
                }.padding(.top)
                
                Section(header: Text("Delivery Address")) {
                    TextField("Street Name",
                              text: $streetName)
                    
                    TextField("Apartment Number",
                              text: $apartmentNumber)
                    
                    TextField("City",
                              text: $city)
                    
                    TextField("Post No",
                              text: $postNumber)
                }
                
                
                Button(action: {
                    self.addUserProfile()
                }) {
                    Text("Add")
                }.frame(alignment: .center)
                
            }
        .navigationBarHidden(true)
            .navigationBarTitle("")
        }
    }
    
    func isUserInformationValid() -> Bool{
        return true
    }
    
    func addUserProfile() {
        self.session.addUserAddress(userProfile: USERPROFILE(firstname: self.firstname,
                                                             lastname: self.lastname,
                                                             telephoneNumber: self.telephoneNumber,
                                                             postNumber: self.postNumber,
                                                             city: self.city,
                                                             streetName: self.streetName,
                                                             apartmentNumber: self.apartmentNumber))
    }
}


/**
 
 
 /**Button(action: {
 
 // validation of phone number not included
 let dash = CharacterSet(charactersIn: "-")
 
 let cleanString =
 hotel.phoneNumber!.trimmingCharacters(in: dash)
 
 let tel = "tel://"
 var formattedString = tel + cleanString
 let url: NSURL = URL(string: formattedString)! as NSURL
 
 UIApplication.shared.open(url as URL)
 
 }) {
 //https://stackoverflow.com/questions/57582653/how-to-create-tappable-url-phone-number-in-swiftui
 //Text("https://stackoverflow.com/questions/57582653/how-to-create-tappable-url-phone-number-in-swiftui")
 }*/
 */
