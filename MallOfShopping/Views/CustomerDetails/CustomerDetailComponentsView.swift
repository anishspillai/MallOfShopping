//
//  CustomerDetailComponentsView.swift
//  MallOfShopping
//
//  Created by Anish Pillai on 2020-05-16.
//  Copyright © 2020 URV. All rights reserved.
//

import SwiftUI

struct HeaderTextView : View {
    
    let headerString: String
    var body: some View {
        HStack {
            
            Text(headerString)
                .font(.system(size: 15, weight: .light, design: .serif))
                .italic()
            
            Spacer()
            
        }.padding(.leading, 10)
    }
}


struct IndividualNonEditableDataView: View {
    let dataToBeDisplayed: String
    
    var body: some View {
        Text(dataToBeDisplayed).font(.subheadline)
    }
}

struct EditFieldButtonView: View {
    
    @Binding var editField: Bool
    
    var body: some View {
        
        Button(action: {
            self.editField.toggle()
        }) {
            Image(systemName: "pencil.circle.fill").font(.headline).foregroundColor(Color.green).padding(10)
        }
    }
}

struct CancelEditFieldButtonView: View {
    
    @Binding var editField: Bool
    
    var body: some View {
        
        Button(action: {
            self.editField.toggle()
        }) {
            Image(systemName: "multiply.circle.fill").font(.title).foregroundColor(Color.red).padding()
        }
    }
}

struct SaveFieldButtonView: View {
    
    var body: some View {
        Image(systemName: "checkmark.circle.fill").font(.title).foregroundColor(Color.green).padding()
    }
}

