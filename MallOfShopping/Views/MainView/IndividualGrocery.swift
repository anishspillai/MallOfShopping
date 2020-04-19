//
//  IndividualGrocery.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct IndividualGrocery: View {
    
    @EnvironmentObject var session: SessionStore
    
    @State var anish = false
    
    @State private var searchText : String = ""
    
    @State private var chunkedGroceryArray = [[GROCERY]]()
    
    @State private var isLoaded = false
    
    var body: some View {
        
        VStack {
            if(false) {
                InitialView()
            }
            else {
                NavigationView {
                    GeometryReader { geometry in
                    VStack {
                        TopMenu()
                        List {
                            if(true) { // Search here
                                ScrollView {
                                    Spacer()
                                    if(true) {
                                        ForEach(0..<self.session.anish.count) { index in
                                            HStack {
                                                ForEach(self.session.anish[index]) { grocery in
                                                    
                                                    NavigationLink(destination: IndividualGroceryDetailView()) {
                                                        
                                                        
                                                        VStack() {
                                                            
                                                            PriceView(grocery: grocery)
                                                            
                                                            GroceryDetailView(grocery: grocery)
                                                            
                                                            GroceryCountStepperView(grocery: grocery)
                                                            
                                                            Spacer()
                                                            
                                                        }
                                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.orange, lineWidth: 1))
                                                        .frame(width: ( geometry.size.width - 50)/3)
                                                        .padding(.trailing, 2).padding(.leading, 1)
                                                    
                                                    }.buttonStyle(PlainButtonStyle())
                                                }
                                            }.padding(.bottom, 5)
                                        }
                                    }
                                }
                            }
                        }
                    } }
                    .navigationBarTitle(Text("Your boutique").foregroundColor(Color.white), displayMode: .inline)
                    .navigationBarItems(trailing: SearchBarView(searchText: $searchText))
               
                }
            }
        }.onAppear(perform: fetchGroceries)
    }
    
    func fetchGroceries() {
        if(!self.isLoaded) { // Do not fetch again once it is loaded.
            self.session.getListOfGroceries()
            self.isLoaded.toggle()
        }
    }
    
    
    
}

struct SearchBarView: View {
    @State private var seachButtonClicked = false
    @State var email: String = "test@gmail.com"
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Group {
                if(!self.seachButtonClicked) {
                    Button(action: {
                        self.seachButtonClicked.toggle()
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill").imageScale(.large).foregroundColor(Color.white)
                    }
                } else {
                    
                    SearchBar(text: $searchText)
                    
                }
            }
        }
    }
}

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("Search", text: $text)
    }
}

struct GroceryCountStepperView: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State private var noOfItems: Int = 0
    @State var displayStepper = false
    
    var grocery: GROCERY
    
    let today = Date()
    let formatter = DateFormatter()
    
    var body: some View {
        HStack () {
            Group {
                if(!self.displayStepper) {
                    Button(action: {
                        self.displayStepper.toggle()
                    }) {
                        Text("Add me")
                    }
                } else {
                    Button(action: {
                        
                        if(self.noOfItems == 1) {
                            self.displayStepper.toggle()
                        }
                        self.noOfItems -= 1
                    }) {
                        Image(systemName: "minus.circle.fill").imageScale(.medium)
                    }
                    
                    Text("\(self.noOfItems)").foregroundColor(Color.black)
                    
                    Button(action: {
                        self.noOfItems += 1
                        let orderedGrocery = ORDERS(id: self.grocery.id.uuidString,
                                                    groceryName: self.grocery.brandName,
                                                    grossWeight: self.grocery.Weight,
                                                    noOfItems: self.noOfItems,
                                                    price: self.grocery.actualPrice,
                                                    timeOfOrder: self.formatter.dateFormat)
                        
                        self.orderedItems.add(item: orderedGrocery)
                    }) {
                        Image(systemName: "plus.circle.fill").imageScale(.medium)
                    }
                }
            }
        }.foregroundColor(Color.orange)
    }
}

struct GroceryDetailView: View {
        
    let grocery: GROCERY
    
    var body: some View {
        VStack {
            
            if(self.grocery.offerPrice > 0) {
                Text("SAVE \(self.getSavedPrice(grocery: self.grocery)) Kr").fontWeight(.bold).foregroundColor(Color.red).font(.footnote)
            }
            
            Text(self.grocery.brandName).font(.footnote).foregroundColor(Color.black)
            Text("\(grocery.Weight) \(grocery.unitOfWeight)").font(.footnote).foregroundColor(Color.black)
        }
    }
    
    func getSavedPrice(grocery: GROCERY) -> String{
        String(format: "%.2f", grocery.actualPrice - grocery.offerPrice)
    }
}


struct PriceView: View {
    
    let grocery: GROCERY
    
    var body: some View {
        ZStack {
            Image("1").resizable().frame(height: 100).padding(.all)
            
            Text(self.getPrice(grocery: grocery))
                .font(.caption)
                .fontWeight(.black)
                .padding(10)
                .background(Color.red)
                .clipShape(Circle())
                .foregroundColor(.white)
                .offset(x: 30, y: -40)
        }
    }
    
    func getPrice(grocery: GROCERY) -> String {
        if(grocery.offerPrice > 0) {
            return String(grocery.offerPrice)
        }
        return String(grocery.actualPrice)
    }
}
struct IndividualGrocery_Previews: PreviewProvider {
    static var previews: some View {
        IndividualGrocery()
    }
}
