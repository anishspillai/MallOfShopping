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
    
    @Published var anish: [[GROCERY]] = [[]]

    
    var ref: DatabaseReference = Database.database().reference(withPath: "users/order-lists/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
    
    let groecery_list = Database.database().reference(withPath: "Error/Groceries")
    
    var userDetails: DatabaseReference = Database.database().reference(withPath: "users/user_details/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
    
    
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
    
    
    
    func getTODOS() {
        ref.observe(DataEventType.value) { (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let toDo = TODOS(snapshot: snapshot) {
                    self.items.append(toDo)
                }
            }
        }
    }
    
    
    func getORDERS() {
        ref.observe(DataEventType.value) { (snapshot) in
            self.orders = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let order = ORDERS(snapshot: snapshot) {
                    self.orders.append(order)
                }
            }
        }
    }
    
    func uploadTODO(todo: String) {
    }
    
    
    
    func getUserGroceries() {
        ref.observe(DataEventType.value) { (snapshot) in
            self.orders = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let order = ORDERS(snapshot: snapshot) {
                    self.orders.append(order)
                }
            }
            print("Grocess vbaseed on user is here")
            print(self.orders)
        }
    }
    
    func getUserAddress() {
        let ref: DatabaseReference = Database.database().reference(withPath: "users/user-details/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        ref.observe(DataEventType.value) { (snapshot) in
            self.orders = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let order = ORDERS(snapshot: snapshot) {
                    self.orders.append(order)
                }
            }
            print("Address List is here ")
            print(self.orders)
        }
    }
    
    
    func addGroceryForTheUser(orders: [ORDERS]) {
        
        let ref: DatabaseReference = Database.database().reference(withPath: "users/order-lists/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        
        
        var data: [Any] = []
        
        for order in orders {
            data.append(order.toJsonFormat())
        }
        
        ref.setValue(data)
        
        self.orderedItems.orderedGroceries = []
        
    }
    
    func addUserAddress(userProfile: USERPROFILE) {
        let ref: DatabaseReference = Database.database().reference(withPath: "users/user-details/\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")
        
        ref.setValue([userProfile.toAnyObject()])
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
            
            self.anish = self.groceryList.chunked(into: 3)
        }
    }
    
    func toAnsihOB() -> Any {
        return [
            "name": "Anish",
            "Apartmano ": "22",
            "Street": "Monstorpsvägen",
            "pin": "14645",
            "telephone": "0723980601"
        ]
    }
    func toAady() -> Any {
        return [
            "name": "Aaadya",
            "Apartmano ": "22",
            "Street": "Monstorpsvägen",
            "pin": "14645",
            "telephone": "0723980601"
        ]
    }
    
    func toSwa() -> Any {
        return [
            "name": "Swathy",
            "Apartmano ": "22",
            "Street": "Monstorpsvägen",
            "pin": "14645",
            "telephone": "0723980601"
        ]
    }
}


extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                print("First if \(index) ")
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                print("Second if \(index) ")
                chunkedArray.append(Array(self[index - 2..<index]))
            }
        }
        
        return chunkedArray
    }
}
