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
            
            
            if(!self.editUserDetails) {
                
                if(self.session.session == nil) {
                    HStack {
                        Image(systemName: "exclamationmark.circle").padding(.leading)
                        Spacer()
                        Text("Please Login and Try again!!").padding(.trailing)
                    }.frame(minWidth: 0, maxWidth: .infinity).padding().background(Color.green)
                } else if(session.customerDeliveryAddress.postNumber.isEmpty) {
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Spacer()
                        Text("Missing Delivery Address!!!")
                    }.frame(minWidth: 0, maxWidth: .infinity).padding().background(Color.green)
                }
                
                Text("User Details").font(.headline).fontWeight(.semibold)
                
                Group {
                    
                    HStack {Text("Mobile Number")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10).padding(.top, 20)
                    
                    HStack {Text(session.customerDeliveryAddress.telephoneNumber).font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    
                    Divider()
                }
                
                Group {
                    HStack {Text("Address")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    
                    HStack {Text("\(session.customerDeliveryAddress.streetName), \(session.customerDeliveryAddress.address)")
                        Spacer()
                    }.padding(25)
                    
                    Divider()
                    
                    HStack {Text("Apartment No")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    HStack {Text("\(session.customerDeliveryAddress.apartmentNumber)").font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    
                    Divider()
                    
                    HStack {Text("Postal Code")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    HStack {Text("\(session.customerDeliveryAddress.postNumber)").font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    
                    Divider()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.editUserDetails = true
                    }) {
                        GreenButtonView(buttonTitle: session.customerDeliveryAddress.postNumber.isEmpty ? "Add" : "Edit")
                    }
                }.padding()
            } else {
                EditUserDetailView(editUserDetails: self.$editUserDetails)
                Spacer()
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
            
            Text("Edit User Details").font(.subheadline).fontWeight(.semibold)
            
            Group {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                TextField("Last Name", text:  $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                
                TextField("Mobile Number", text:  $telephoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
            }
            
            Group {
                
                TextField("Apartment No", text:  $postNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                
                TextField("Street Name", text:  $streetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                
                TextField("Address", text:  $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                
                TextField("Post Number", text:  $apartmentNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.editUserDetails.toggle()
                }) {
                    Image(systemName: "return")
                }.padding(.trailing)
                
                
                Button(action: {
                    let customerDeliveryAddress = CustomerDeliveryAddress(firstName: self.firstName,
                                                                          lastName: self.lastName,
                                                                          telephoneNumber: self.telephoneNumber,
                                                                          postNumber: self.postNumber,
                                                                          address: self.address,
                                                                          streetName: self.streetName,
                                                                          apartmentNumber: self.apartmentNumber)
                    self.session.addUserAddress(customerDeliveryAddress: customerDeliveryAddress)
                    self.editUserDetails.toggle()
                }) {
                    GreenButtonView(buttonTitle: "Save")
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
