//
//  Inflation.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 31/03/2023.
//

import SwiftUI

struct Investing: View {
    @State private var action: Int? = 0
    private let steps: [String] = [
        "Determine your financial goals and risk tolerance.",
        "Educate yourself about the different types of investments available, such as stocks, bonds, and mutual funds.",
        "Open a brokerage account with a reputable firm.",
        "Create a diversified portfolio to minimize risk.",
        "Monitor your investments regularly and make adjustments as needed.",
        "Be patient, stay focused on your long-term objectives, and avoid making snap decisions based on temporary market movements."
    ]
    
    var body: some View {
        ScrollView {
            Text("Investing")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Once you've started saving money, it's important to consider the next step - investing. Investing your savings can help you build wealth and achieve your financial goals over the long term.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Here are the steps to help you get started with investing:")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.horizontal)

            VStack(alignment: .leading) {
                ForEach(Array(steps.enumerated()), id: \.offset) { (index, item) in
                    HStack {
                        Text("\(index + 1).")
                            .fontWeight(.semibold)
                        Text("\(item)")
                    }
                    .padding(.bottom, 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 2)
            
            if #available(iOS 16.0, *) {
                NavigationLink (destination: InvestingSimulation(), tag: 1, selection: $action) {
                    
                }
                
                Button("Simulation") {
                    self.action = 1
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
                .padding(.bottom, 50)
            }
        }
    }
}

struct Investing_Previews: PreviewProvider {
    static var previews: some View {
        Investing()
    }
}
