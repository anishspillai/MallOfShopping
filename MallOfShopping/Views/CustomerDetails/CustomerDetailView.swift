//
//  CustomerDetailView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-10.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct CustomerDetailView: View {
    var body: some View {
        DisplayUserDetails()
    }
}

struct CustomerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailView()
    }
}

struct DisplayUserDetails : View {
    @State private var editUserDetails = false
    
    @EnvironmentObject var session: SessionStore
    
    @State private var editMobileNumber = false
    @State private var editAddress = false
    @State private var editApartmentNo = false
    @State private var editPostalCode  = false
    
    
    var body: some View {
        VStack() {
            
            ZStack {
                VStack {
                    Rectangle().foregroundColor(Color.purple).frame(height: 150)
                        .clipShape(CustomShape()).padding(.top, 0)
                }
                
                Image(systemName: "person.crop.circle.fill").resizable().frame(width:50, height: 50).foregroundColor(Color.white)
                
                Text("Hej!   \(session.customerDeliveryAddress.firstName) \(session.customerDeliveryAddress.lastName)").offset(x: 0, y:50).foregroundColor(Color.white)
                
            }.padding(.bottom)
            
            Spacer().frame(height: 10)
            
            
            
            if(self.session.session == nil) {
                HStack {
                    Image(systemName: "exclamationmark.circle").padding(.leading)
                    Spacer()
                    Text("Please Login and Try again!!").padding(.trailing)
                }.frame(minWidth: 0, maxWidth: .infinity).padding().background(Color.green)
                Spacer()
            } else {
                
                if(session.customerDeliveryAddress.postNumber.isEmpty) {
                    
                    EditUserDetailView(editUserDetails: self.$editUserDetails)
                    Spacer()
                    
                } else {
                    ContactNumberView()
                    
                    AddressView()
                    
                    ApartmentNoView()
                    
                    PostCodeView()
                    
                    Spacer()
                }
            }
            
        }.onAppear(perform: fetchUserDetails)
    }
    
    func fetchUserDetails() {
        session.listen()
        self.session.fetchUserDeliveryAddress()
    }
}

struct EditUserDetailView : View {
    
    @Binding var editUserDetails: Bool
    
    @EnvironmentObject var session: SessionStore
    
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var telephoneNumber: String = ""
    
    @State private var postNumber: String = ""
    @State private var address: String = ""
    @State private var streetName: String = ""
    @State private var apartmentNumber: String = ""
    var body: some View {
        VStack {
            
            Text("Add User Details").font(.subheadline).fontWeight(.semibold)
            
            Group {
                
                
                HStack {
                    Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("First Name", text:  $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                
                HStack {
                    Text("  ").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("Last Name, not mandatory", text:  $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                
                TelephoneNumberInputView(telephoneNumber: $telephoneNumber)
                
                Divider()
            }
            
            Group {
                
                HStack {
                    Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("Apartment No", text:  $apartmentNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                
                HStack {
                    Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("Street Name", text:  $streetName)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                HStack {
                    Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                    TextField("Address", text:  $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                }
                
                PinCodeInputView(pinCode: $postNumber)
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    let customerDeliveryAddress = CustomerDeliveryAddress(firstName: self.firstName,
                                                                          lastName: self.lastName,
                                                                          telephoneNumber: self.telephoneNumber,
                                                                          postNumber: self.postNumber,
                                                                          address: self.address,
                                                                          streetName: self.streetName,
                                                                          apartmentNumber: self.apartmentNumber)
                    self.session.addUserAddress(customerDeliveryAddress: customerDeliveryAddress)
                }) {
                    if(firstName.isEmpty ||
                        telephoneNumber.count < 10 ||
                        postNumber.count < 5 ||
                        address.isEmpty ||
                        streetName.isEmpty ||
                        apartmentNumber.isEmpty) {
                        Text("*** Save button appears after filling all the fields ***")
                            .font(.system(size: 12, weight: .light, design: .serif))
                            .disabled(true)
                            .foregroundColor(Color.red)
                    } else {
                        GreenButtonView(buttonTitle: "Save", isWidthFixed: true)
                    }
                    
                }.padding(.trailing)
            }
            
            Spacer()
        }
    }
}


struct CustomShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomLeft,
                                cornerRadii: CGSize(width: 55, height: 55))
        return Path(path.cgPath)
    }
}


struct TelephoneNumberInputView : View {
    
    @Binding  var telephoneNumber: String
    var body: some View {
        VStack {
            HStack {
                Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                
                TextField("10 digits, ex 0123456987", text:  $telephoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
            }
            
            if(!TelephoneNumberValidator.isValidContact(contactNumber: self.telephoneNumber)) {
                Text("Invalid Telephone Number, requires 10 digit number with starting 0")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(Color.red).lineLimit(2)
            }
        }
    }
}

struct PinCodeInputView : View {
    
    @Binding var pinCode: String
    var body: some View {
        VStack {
            
            if(!PinCodeValidator.isValidPinNumber(pinNumber: self.pinCode)) {
                Text("Invalid Pin Code Number, requires 5 digits number")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .italic()
                    .foregroundColor(Color.red)
            }
            
            HStack {
                Text("*").font(.headline).foregroundColor(Color.red).padding(.leading, 5)
                
                TextField("5 digits postal code , ex 12345", text:  $pinCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
            }
        }
    }
}
