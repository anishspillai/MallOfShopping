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
    var body: some View {
        VStack() {
            
            ZStack {
                Rectangle().foregroundColor(Color.purple).frame(height: 150)
                    .clipShape(CustomShape())
                
                Image(systemName: "person.crop.circle.fill").resizable().frame(width:50, height: 50).foregroundColor(Color.white)
                
                Text("Hej! Anish Sasiharan Pillai Ansih ").offset(x: 0, y:50).foregroundColor(Color.white)
                
            }
            Spacer()
            
            if(!self.editUserDetails) {
                Group {
                    
                    HStack {Text("Mobile Number")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10).padding(.top, 20)
                    HStack {Text("0723980601").font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    Divider()
                }
                
                Group {
                    HStack {Text("Street Name")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    
                    HStack {Text("Månstorpsvägen 22, Tullinge, Tamizha tamizha, nalum, nammd, anish spi lia , and the cause of the change is that the no of the cases increase day by day").font(.subheadline)
                        Spacer()
                    }.padding(25)
                    
                    Divider()
                    
                    HStack {Text("Apartment No")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    HStack {Text("22").font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    
                    Divider()
                    
                    HStack {Text("Postal Code")
                        .font(.system(size: 15, weight: .light, design: .serif))
                        .italic()
                        Spacer()
                    }.padding(.leading, 10)
                    
                    HStack {Text("14546").font(.subheadline)
                        Spacer()
                    }.padding(.leading, 25)
                    
                    Divider()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        self.editUserDetails = true
                    }) {
                        GreenButtonView(buttonTitle: "Edit")
                    }
                }.padding()
            } else {
                EditUserDetailView(editUserDetails: self.$editUserDetails)
                Spacer()
            }
        }
    }
}

struct EditUserDetailView : View {
    
    @Binding var editUserDetails: Bool
    
    
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var telephoneNumber: String = ""
    
    @State private var postNumber: String = ""
    @State private var city: String = ""
    @State private var streetName: String = ""
    @State private var apartmentNumber: String = ""
    var body: some View {
        VStack {
            
            Text("Edit User Details").font(.title).fontWeight(.semibold).underline()
            
            Group {
                TextField("First Name", text:  $firstname)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
                
                TextField("Last Name", text:  $lastname)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
                
                TextField("Mobile Number", text:  $telephoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
            }
            
            Group {
                
                TextField("Apartment No", text:  $postNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
                
                
                TextField("First Name", text:  $streetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding(.leading).padding(.trailing)
                
                Divider()
                
                
                TextField("Address", text:  $apartmentNumber)
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
                    //self.editUserDetails = true
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
