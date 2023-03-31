//
//  Inflation.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 31/03/2023.
//

import SwiftUI

struct Inflation: View {
    var body: some View {
        VStack {
            Text("Some information inflation")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Some description Some descriptionSome descriptionSome descriptionSome descriptionSome descriptionSome description")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct Inflation_Previews: PreviewProvider {
    static var previews: some View {
        Inflation()
    }
}
