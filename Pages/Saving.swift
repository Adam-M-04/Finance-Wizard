//
//  Saving.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 01/04/2023.
//

import SwiftUI

struct Saving: View {
    var body: some View {
        VStack {
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
            
            Text("By tracking your expenses, you can identify areas where you may be overspending and make adjustments to your budget accordingly.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("The 50/30/20 rule suggests that you allocate 50% of your budget for your essential needs, 30% for your personal wants, and reserve 20% for your savings.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            if #available(iOS 16.0, *) {
                NavigationLink (destination: ExpensesTracking()) {
                    Text("Track your expenses ->")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct Saving_Previews: PreviewProvider {
    static var previews: some View {
        Saving()
    }
}
