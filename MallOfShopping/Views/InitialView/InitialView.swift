//
//  InitialView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-04-18.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        VStack {
            Text("Welcome to").font(.custom("Heiti TC", size: 30)).fontWeight(.light).foregroundColor(Color.orange)
            Text("Mall of Groceries").font(.custom("Heiti TC", size: 40)).fontWeight(.bold).foregroundColor(Color.orange)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
    


    init (){

        

    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
       
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
