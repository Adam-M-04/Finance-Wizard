//
//  SwiftUIView.swift
//  
//
//  Created by Adam Mąka on 01/04/2023.
//

import SwiftUI
import Charts

struct SwiftChart: View {
    let data: [DataStruct]
    let title: String
    let type: ChartType
    let unit: String
    
    var body: some View {
        if #available(iOS 16.0, *) {
            VStack {
                Text(title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                if type == .line {
                    Chart (data) {
                        LineMark(
                            x: .value("Description", $0.description),
                            y: .value("Value", $0.value)
                        )
                        PointMark(
                            x: .value("Description", $0.description),
                            y: .value("Value", $0.value)
                        )
                    }
                    .frame(height: 250)
                    .padding(.horizontal)
                    .accentColor(.white)
                    .colorScheme(.dark)
                }
                if type == .bar{
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
                        }
                    }
                    .frame(height: 300)
                    .padding(.horizontal)
                    .accentColor(.white)
                    .colorScheme(.dark)
                }
            }
        }
        else {
            LineChartLegacy(data: data, title: title)
                .frame(height: 300)
                .padding()
        }
        
    }
}

struct SwiftChart_Previews: PreviewProvider {
    static var previews: some View {
        SwiftChart(data: [], title: "", type: .line, unit: "")
    }
}

enum ChartType {
    case line, bar
}
