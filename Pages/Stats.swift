//
//  Stats_1.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 31/03/2023.
//

import SwiftUI

struct Stats: View {
    // Data from "https://www.zippia.com/advice/american-savings-statistics/"
    let savingFacts = [
        "Around 42% of Americans have less than $1,000 in savings as of 2022",
        "A considerable 10% of Americans have no savings at all",
        "Only 28% of Americans could survive three months on their emergency savings"]
    
    let bgOpacity: Double
    
    var body: some View {
        ScrollView {
            Text("Savings")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Achieving your goals can be a challenging journey, but saving money is a crucial pathway that can make it possible.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("🤔")
                .font(.system(size: 80))
                .padding(-10)
            
            Text("Saving money not only helps you achieve your goals, but also allows you to build a financial safety net, giving you peace of mind and greater financial stability.")
                .font(.title3)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("Worrying Facts")
                .font(.title)
                .padding(.top, 25)
                .padding(.bottom, 10)
            VStack {
                ForEach(savingFacts, id: \.self) { text in
                    HStack {
                        Text("•")
                            .font(.title)
                        Text(text)
                            .font(.body)
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .opacity(bgOpacity)
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats(bgOpacity: 1)
    }
}
