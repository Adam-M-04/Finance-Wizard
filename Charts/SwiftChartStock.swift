//
//  SwiftUIView.swift
//  
//
//  Created by Adam Mąka on 08/04/2023.
//

import SwiftUI
import Charts

struct SwiftChartStock: View {
    let data: [DataStructureVertical]
    
    var body: some View {
        let minVal = findMin()
        let maxVal = findMax()
        let chartColor = getChartColor()
        let chartLineColor: Color = data.first!.value > data.last!.value ? .red : .green
        let price = data.last!.value
        let priceDiff = data.last!.value - data[data.count - 2].value
        
        if #available(iOS 16.0, *) {
            VStack {
                HStack {
                    Text("AAPL")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    HStack (alignment: .center) {
                        Text("Apple inc.")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.bottom, -10)
                    }
                    Spacer()
                    
                    Text(String(format: "$%.2f", priceDiff))
                        .font(.caption)
                        .animation(.linear)
                        .foregroundColor(priceDiff < 0 ? .red : .green)
                    Text(String(format: "$%.2f", price))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .animation(.linear)
                }
                .padding(.bottom, -5)
                
                Chart {
                    ForEach(data, id: \.id) { lineData in
                        LineMark(
                            x: .value("Description", lineData.description),
                            y: .value("Value", lineData.value)
                        )
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .accessibilityLabel("\(lineData.description)")
                        .accessibilityValue("$\(lineData.value)")
                        .foregroundStyle(chartLineColor)
                        
                        AreaMark(
                            x: .value("Description", lineData.description),
                            y: .value("Value", lineData.value)
                        )
                        .accessibilityLabel("\(lineData.description)")
                        .accessibilityValue("$\(lineData.value)")
                        .foregroundStyle(
                            chartColor
                        )
                        .alignsMarkStylesWithPlotArea()
                        
                    }
                    
                }
                .clipShape(Rectangle())
                .frame(height: 250)
                .chartYScale(domain: minVal...maxVal)
                .chartYAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisGridLine()
                        AxisTick(centered: true, stroke: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(Color.gray)
                        AxisValueLabel() {
                            if let val = value.as(Int.self) {
                                Text("$\(val)")
                                    .font(.system(size: 10))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .chartXAxis {
                  AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                      AxisTick(stroke: StrokeStyle(dash: [1, 2]))
                          .foregroundStyle(Color.gray)
                    AxisValueLabel()
                  }
                }
            }
        }
        else {
            Text("You need iOS 16 or higher to support charts")
                .font(.title)
        }
    }
    
    private func findMin() -> Int {
        let values = data.map { $0.value }
        return Int(values.min() ?? 5) - 5
    }
    
    private func findMax() -> Int {
        let values = data.map { $0.value }
        return Int(values.max() ?? 5) + 5
    }
    
    private func getChartColor() -> LinearGradient {
        if data.first!.value > data.last!.value {
            return .linearGradient(
                colors: [.red.opacity(0.8), .red.opacity(0.5), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        return .linearGradient(
            colors: [.green.opacity(0.8), .green.opacity(0.5), .clear],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
