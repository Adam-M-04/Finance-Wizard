//
//  Inflation.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 31/03/2023.
//

import SwiftUI

struct Investing: View {
    @State private var navAction: Int? = 0
    private let steps: [String] = [
        "Determine your financial goals and risk tolerance.",
        "Explore the different types of investments available, such as stocks, bonds, and mutual funds.",
        "Open a brokerage account with a reputable company.",
        "Create a diversified portfolio to minimize risk.",
        "Monitor your investments regularly and make adjustments as needed.",
        "Be patient, stay focused on your long-term objectives, and avoid making snap decisions based on temporary market movements."
    ]
    
    let bgOpacity: Double
    
    var body: some View {
        ScrollView {
            Text("Investing")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Once you have started saving money, it is important to consider the next step - investing. Investing your savings can help you build wealth and achieve your financial goals over the long term.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            if #available(iOS 16.0, *) {
                NavigationLink (destination: InvestingSimulation(), tag: 1, selection: $navAction) {}
                
                Button("Simulation \(Image(systemName: "function"))") {
                    self.navAction = 1
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
            }
            
            Text("Here are the steps to help you get started investing:")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.bottom, 2)
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
            .padding(.bottom, 40)
        }
        .opacity(bgOpacity)
    }
}

struct Investing_Previews: PreviewProvider {
    static var previews: some View {
        Investing(bgOpacity: 1)
    }
}
