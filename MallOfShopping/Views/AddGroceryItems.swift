//
//  AddItems.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-17.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI



struct AddGroceryItems: View {
    
    @EnvironmentObject var session: SessionStore


    @State var orders: [GROCERY] = []

    var body: some View {
        
        
        Button(action: {
           
            let grocery = GROCERY(type: "Basmati Rice", brandName: "Laila", Weight: 10, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery1 = GROCERY(type: "Basmati Rice", brandName: "Alishaan", Weight: 7, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery2 = GROCERY(type: "Basmati Rice", brandName: "India Gate", Weight: 6, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery3 = GROCERY(type: "Basmati Rice", brandName: "Alishaan Deligth", Weight: 5, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery4 = GROCERY(type: "Basmati Rice", brandName: "Alishaan Superb", Weight: 8, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery5 = GROCERY(type: "Basmati Rice", brandName: "Everest", Weight: 10, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery6 = GROCERY(type: "Basmati Rice", brandName: "Tidla", Weight: 10, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery7 = GROCERY(type: "Basmati Rice", brandName: "Tidla Original", Weight: 8, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery8 = GROCERY(type: "Basmati Rice", brandName: "Ecerest extra Lonkorni", Weight: 7, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery9 = GROCERY(type: "Basmati Rice", brandName: "Indai Gae Pemium", Weight: 3, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery10 = GROCERY(type: "Basmati Rice", brandName: "Brown Laila Rice", Weight: 3, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery11 = GROCERY(type: "Basmati Rice", brandName: "Alishaan Superb", Weight: 8, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery12 = GROCERY(type: "Basmati Rice", brandName: "Indai Gate Sella", Weight: 10, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery13 = GROCERY(type: "Wheat Flour", brandName: "Aashirvaad Chakki Atta", Weight: 5, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery14 = GROCERY(type: "Wheat Flour", brandName: "Abc", Weight: 5, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery15 = GROCERY(type: "Sooji and Rava", brandName: "ine Cornmeal", Weight: 6, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            let grocery16 = GROCERY(type: "Maida", brandName: "Anish", Weight: 3, unitOfWeight: "KG" , actualPrice: 100.0, offerPrice: 80.00, id: UUID())
            
            self.orders.append(grocery)
            self.orders.append(grocery1)
            self.orders.append(grocery2)
            self.orders.append(grocery3)
            self.orders.append(grocery4)
            self.orders.append(grocery5)
            self.orders.append(grocery6)
            self.orders.append(grocery7)
            self.orders.append(grocery8)
            self.orders.append(grocery9)
            self.orders.append(grocery10)
            self.orders.append(grocery11)
            self.orders.append(grocery12)
            self.orders.append(grocery13)
            self.orders.append(grocery14)
            self.orders.append(grocery15)
            self.orders.append(grocery16)
            
            
            self.session.addGroceryByAdmin(orders: self.orders)
        }) {
            Text("ADMIN - ADD GROCERY")
        }
    }
}

struct AddItems_Previews: PreviewProvider {
    static var previews: some View {
        AddGroceryItems()
    }
}
