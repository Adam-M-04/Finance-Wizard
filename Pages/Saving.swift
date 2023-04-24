//
//  Saving.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 01/04/2023.
//

import SwiftUI

struct Saving: View {
    @State private var navAction: Int? = 0
    let bgOpacity: Double
    
    var body: some View {
        ScrollView {
            Text("How to start saving")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("To begin saving money, it's essential to determine your expenses by keeping a record of all your spending.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("💰")
                .font(.system(size: 80))
                .padding(-10)
            
            Text("By tracking your spendings, you can identify areas where you may be overspending and make adjustments to your budget accordingly.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            if #available(iOS 16.0, *) {
                NavigationLink (destination: ExpensesTracking(), tag: 1, selection: $navAction) {}
                
                Button("Track your expenses \(Image(systemName: "dollarsign.circle.fill"))") {
                    self.navAction = 1
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
            }
            
            Text("The 50/30/20 rule suggests that you allocate 50% of your budget for your essential needs, 30% for your personal wants, and reserve 20% for your savings.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
        }
        .opacity(bgOpacity)
    }
}

struct Saving_Previews: PreviewProvider {
    static var previews: some View {
        Saving(bgOpacity: 1)
    }
}
