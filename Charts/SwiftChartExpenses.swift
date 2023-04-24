//
//  SwiftUIView.swift
//  
//
//  Created by Adam Mąka on 01/04/2023.
//

import SwiftUI
import Charts

struct SwiftChartExpenses: View {
    @Environment(\.colorScheme) var colorScheme
    let data: [DataStruct]
    let unit: String
    let lightOnly: Bool
    let barColors: [Color]
        
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                Chart {
                    ForEach(data, id: \.id) { barData in
                        BarMark(
                            x: .value("Value", barData.value),
                            y: .value("Description", barData.description)
                        )
                        .annotation(position: .trailing) {
                            Text(String(format: "%.0f", barData.value) + unit)
                            .font(.caption)
                        }
                        .accessibilityLabel("\(barData.description)")
                        .accessibilityValue("\(barData.value)")
                        .foregroundStyle(
                            .linearGradient(
                                colors: barColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .alignsMarkStylesWithPlotArea()
                    }
                }
                .frame(height: 300)
                .padding(.horizontal)
                .colorScheme(lightOnly ? .dark : colorScheme)
            }
        }
        else {
            Text("You need iOS 16 or higher to support charts")
                .font(.title)
        }
        
    }
}
