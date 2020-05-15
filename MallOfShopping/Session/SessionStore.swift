//
//  SessionStore.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-13.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    @EnvironmentObject var orderedItems: OrderedItems
    
    
    @Published var items: [TODOS] = []
    
    @Published var orders: [ORDERS] = []
    
    @Published var groceryList: [GROCERY] = []
    
    @Published var groceryListInGridFormat: [[GROCERY]] = [[]]
    
    @Published var sideBarMenuModelList: [SideBarMenuModel] = []
    
    @Published var groceryListByType: [GROCERY] = []
    
    @Published var groceryListGridByType: [[GROCERY]] = [[]]
    
    @Published var customerDeliveryAddress: CustomerDeliveryAddress = CustomerDeliveryAddress()
    
    @Published var orderHistories: [OrderHistory] = []
    
    @Published var orderPlacementStatus = ""
    
    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
                //self.getGroceries()
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func getOrderHistory() {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/order-lists/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        ref.observe(DataEventType.value) { (snapshot) in
            self.orderHistories = []
            
            for parent in snapshot.children {
                let parentSnapShot = parent as? DataSnapshot
                
                var orderHistory: OrderHistory = OrderHistory(orderedTime: parentSnapShot!.key)
                var ordersInThePast : [ORDERS] = []
                
                for child in parentSnapShot!.children {
                    if let snapshot = child as? DataSnapshot,
                        let order = ORDERS(snapshot: snapshot) {
                        ordersInThePast.append(order)
                    }
                }
                orderHistory.orders = ordersInThePast
                self.orderHistories.append(orderHistory)
            }
            
        }
    }
    
    func addGroceryForTheUser(orderedItems: OrderedItems) {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/order-lists/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        let currentTimeStamp = Int(Date.timeIntervalSinceReferenceDate)
        
        let childPath = "/" + String(currentTimeStamp)
        
        let postRef = ref.child(childPath)
        
        var data: [Any] = []
        
        for order in orderedItems.orderedGroceries {
            data.append(order.toJsonFormat())
        }
        
        
        postRef.setValue(data, withCompletionBlock: { (error, ref) in
            
            if (error == nil) {
                orderedItems.orderedGroceries = []
                self.orderPlacementStatus = "success"
            } else {
                self.orderPlacementStatus = "failed"
            }
        })
        
    }
    
    func addUserAddress(customerDeliveryAddress: CustomerDeliveryAddress) {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/user-details/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        ref.setValue([customerDeliveryAddress.toAnyObject()])
    }
    
    
    func fetchUserDeliveryAddress()  {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/user-details/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        
        ref.observe(DataEventType.value) { (snapshot) in
            
           
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let customerDeliveryAddress = CustomerDeliveryAddress(snapshot: snapshot) {
                    self.customerDeliveryAddress = customerDeliveryAddress
                }
            }
            
        }
    }
    
    
    
    func addGroceryByAdmin(orders: [GROCERY]) {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "admin/Grocery")
        
        
        ref.setValue([ orders[0].toAnyObject(),
                       orders[1].toAnyObject(),
                       orders[2].toAnyObject(),
                       orders[3].toAnyObject()
            , orders[4].toAnyObject()
            , orders[5].toAnyObject()
            , orders[6].toAnyObject()
            , orders[7].toAnyObject()
            , orders[8].toAnyObject()
            , orders[9].toAnyObject()
            , orders[10].toAnyObject()
            , orders[11].toAnyObject()
            , orders[12].toAnyObject()
            , orders[13].toAnyObject()
            , orders[14].toAnyObject()
            , orders[15].toAnyObject()
            , orders[16].toAnyObject()])
    }
    
    
    
    func getListOfGroceries()  {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "admin/Grocery")
        
        ref.observe(DataEventType.value) { (snapshot) in
            self.groceryList = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let order = GROCERY(snapshot: snapshot) {
                    
                    self.groceryList.append(order)
                }
            }
            
            if(!self.groceryList.isEmpty) {
                self.groceryListInGridFormat = self.groceryList.chunked(into: 3)
            }
        }
    }
    
    func getFilteredGroceryList(groceryType: String, grocerySubType: String)  {
        
        let groceryReference = grocerySubType.isEmpty ? groceryType + "/" + groceryType : groceryType + "/" + grocerySubType
        
        let ref: DatabaseReference = Database.database().reference(withPath: "admin/Catagories/" + groceryReference)
        
        self.groceryListByType = []
        self.groceryListGridByType = [[]]
        
        ref.observe(DataEventType.value) { (snapshot) in
            
            
            
            //for child in snapshot.children {
            
            //let snapshot = child as? DataSnapshot
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let order = GROCERY(snapshot: snapshot) {
                    self.groceryListByType.append(order)
                }
            }
            
            //}
            
            
            
            if(!self.groceryListByType.isEmpty) {
                self.groceryListGridByType = self.groceryListByType.chunked(into: 3)
            }
        }
    }
    
    func getCatagoriesForSideBarMenu() {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "admin/SearchCatagory")
        
        ref.observe(DataEventType.value) { (snapshot) in
            self.sideBarMenuModelList = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let sideBarMenuModel: SideBarMenuModel = SideBarMenuModel(snapshot: snapshot) {
                    self.sideBarMenuModelList.append(sideBarMenuModel)
                }
            }
        }
    }
}


extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                chunkedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return chunkedArray
    }
}
