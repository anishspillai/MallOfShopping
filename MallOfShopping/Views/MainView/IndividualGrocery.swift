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
    
    @State private var isLoaded = false
    
    @State private var displaySidebarMenu = false
    
    
    var body: some View {
        
        VStack {
            if(session.groceryListInGridFormat.isEmpty) {
                //InitialView()
                Text("Loading")
            }
            else {
                NavigationView {
                    ZStack {
                        GeometryReader { geometry in
                            VStack {
                                
                                TopMenu()
                                
                                ScrollView(showsIndicators: false) {
                                    
                                    Rectangle().frame(width: geometry.size.width, height: 0.01)
                                    
                                    Spacer()
                                    
                                    ForEach(0..<self.session.groceryListInGridFormat.count, id: \.self) { index in
                                        HStack {
                                            ForEach(self.session.groceryListInGridFormat[index]) { grocery in
                                                
                                                NavigationLink(destination:IndividualGroceryDetailView()) {
                                                    
                                                    VStack() {
                                                        
                                                        PriceView(grocery: grocery)
                                                        
                                                        GroceryDetailView(grocery: grocery)
                                                        
                                                        GroceryCountStepperView(grocery: grocery)
                                                        
                                                        Spacer()
                                                        
                                                    }
                                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.orange, lineWidth: 1))
                                                    .frame(width: (geometry.size.width - 50)/3)
                                                    .padding(.trailing, 2).padding(.leading, 1)
                                                    
                                                }.buttonStyle(PlainButtonStyle())
                                            }
                                        }.padding(.bottom, 5)
                                    }
                                }
                                
                                
                            }
                            
                        }
                        .navigationBarTitle(Text("Your boutique").foregroundColor(Color.white), displayMode: .inline)
                        .navigationBarItems(leading: Button(action: {
                            self.displaySidebarMenu.toggle()
                        }, label: {
                            Image(systemName: "circle.grid.3x3.fill").foregroundColor(Color.white)
                        })
                        )
                        
                        SideBarMainPageView(displayMenu: self.$displaySidebarMenu).offset(x:-75).opacity(self.displaySidebarMenu ? 1.5: 0.0)
                    }
                    
                    
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

struct GroceryView: View {
    let grocery: GROCERY
    var body: some View {
        GeometryReader { geometry in
            
            NavigationLink(destination:IndividualGroceryDetailView()) {
                
                VStack() {
                    
                    PriceView(grocery: self.grocery)
                    
                    GroceryDetailView(grocery: self.grocery)
                    
                    GroceryCountStepperView(grocery: self.grocery)
                    
                    Spacer()
                    
                }
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.orange, lineWidth: 1))
                .frame(width: (geometry.size.width - 50)/3)
                .padding(.trailing, 2).padding(.leading, 1)
                
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

struct GroceryCountStepperView: View {
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    @State private var noOfItems: Int = 1
    @State var displayStepper = false
    
    var grocery: GROCERY
    
    var body: some View {
        VStack () {
            if(!self.isAlreadyPlacedThisItem()) {
                Button(action: {
                    self.addOrderToTheOrderedList()
                }) {
                    GreenButtonView(buttonTitle: "Add")
                }
            } else {
                HStack{
                    Button(action: {
                        self.orderedItems.decrement(idOfTheItem: self.grocery.id.uuidString)
                    }) {
                        Image(systemName: "minus.circle.fill").imageScale(.medium)
                    }
                    
                    Text("\(self.getNoOfItemsFromOrderedList())")
                    
                    Button(action: {
                        self.orderedItems.increament(idOfTheItem: self.grocery.id.uuidString)
                    }) {
                        Image(systemName: "plus.circle.fill").imageScale(.medium)
                    }
                }
            }
        }.foregroundColor(Color.orange)
    }
    
    
    func isAlreadyPlacedThisItem() -> Bool {
        if(!self.orderedItems.orderedGroceries.isEmpty) {
            return self.orderedItems.orderedGroceries.contains(where: { $0.id == self.grocery.id.uuidString })
        }
        return false
    }
    
    
    func getNoOfItemsFromOrderedList() -> Int {
        if(!self.orderedItems.orderedGroceries.isEmpty) {
            let order: ORDERS! = self.orderedItems.orderedGroceries.first(where: { $0.id == self.grocery.id.uuidString })
            if(order != nil) {
                return order.noOfItems
            }
        }
        return 1
    }
    
    func addOrderToTheOrderedList() {
        
        let orderedGrocery = ORDERS(id: self.grocery.id.uuidString,
                                    groceryName: self.grocery.brandName,
                                    grossWeight: self.grocery.Weight,
                                    noOfItems: 1,
                                    price: self.grocery.actualPrice,
                                    type: self.grocery.type)
        
        self.orderedItems.add(item: orderedGrocery)
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
            
        }.frame(height: 45	)
    }
    
    func getSavedPrice(grocery: GROCERY) -> String{
        String(format: "%.2f", grocery.actualPrice - grocery.offerPrice)
    }
}


struct PriceView: View {
    
    let grocery: GROCERY
    
    var body: some View {
        ZStack {
            Image("1").resizable().frame(height: 100).padding(		.all)
            
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
