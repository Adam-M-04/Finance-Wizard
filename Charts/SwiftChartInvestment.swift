//
//  SwiftUIView.swift
//  
//
//  Created by Adam Mąka on 04/04/2023.
//

import SwiftUI
import Charts

struct SwiftChartInvestment: View {
    //@State var selectedElement: DataStructureVertical?
    //@State var selectedBaseElement: DataStructureVertical?
    @Binding var selectedElementIndex: Int?
    let data: [DataStructureVertical]
    let baseData: [DataStructureVertical]
    let unit: String
    let ColorScheme: ColorScheme
    let barColors: [Color]
        
    var body: some View {
        if #available(iOS 16.0, *) {
            let doubleData = [
                (name: "Idle money in bank", data: baseData),
                (name: "Invested money", data: data)
            ]
            
            VStack {
                Chart (doubleData, id: \.name) { chartData in
                    ForEach(chartData.data, id: \.id) { barData in
                        BarMark(
                            x: .value("Description", barData.description),
                            y: .value("Value", barData.value)
                        )
                        .accessibilityLabel("Description: \(barData.description), value: \(barData.value)")
                        .foregroundStyle(
                            by: .value("data", chartData.name)
                        )
                    }
                }
                .frame(height: 300)
                .colorScheme(ColorScheme)
                .chartYAxisLabel("Investment value [$]")
                .chartYAxis {
                  AxisMarks(values: .automatic) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
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
                .chartOverlay { proxy in
                    GeometryReader { geo in
                        Rectangle()
                            .fill(.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                SpatialTapGesture()
                                    .onEnded { value in
                                        let newIndex = ChartElementFinder(location: value.location, proxy: proxy, geometry: geo)
                                        if newIndex == selectedElementIndex {
                                            selectedElementIndex = nil
                                        } else {
                                            selectedElementIndex = newIndex
                                        }
                                    }
                                    .exclusively(before: DragGesture()
                                        .onChanged { value in
                                            selectedElementIndex = ChartElementFinder(location: value.location, proxy: proxy, geometry: geo)
                                        })
                            )
                    }
                }
                .chartBackground { proxy in
                    ZStack(alignment: .topLeading) {
                        GeometryReader { gr in
                            if let selectedElementIndex {
                                if selectedElementIndex < data.count {
                                    let selectedElement = data[selectedElementIndex]
                                    let selectedBaseElement = baseData[selectedElementIndex]
                                    let interval = Calendar.current.dateInterval(of: .year, for: selectedElement.description)!
                                    let startX = proxy.position(forX: interval.start) ?? 0
                                    let midStartX = startX + gr[proxy.plotAreaFrame].origin.x
                                    let lineShift: CGFloat = 20
                                    let lineHeight = gr[proxy.plotAreaFrame].maxY - lineShift
                                    let minBoxWidth: CGFloat = 100
                                    let boxOffset = max(0, min(gr.size.width - minBoxWidth - 100, midStartX - minBoxWidth / 2))
                                    
                                    
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width: 2, height: lineHeight)
                                        .position(x: midStartX, y: lineHeight / 2 + lineShift)
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(selectedElement.description, format: .dateTime.year())")
                                            .font(.callout.bold())
                                            .foregroundColor(.primary)
                                        HStack {
                                            Circle()
                                                .fill(.green)
                                                .frame(width: 10, height: 10)
                                                .padding(.trailing, -5)
                                            Text("$\(selectedElement.value + selectedBaseElement.value, format: .number)")
                                                .font(.callout)
                                                .foregroundColor(.primary)
                                        }
                                        .padding(.vertical, -5)
                                        HStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 10, height: 10)
                                                .padding(.trailing, -5)
                                            Text("$\(selectedBaseElement.value, format: .number)")
                                                .font(.callout)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    .frame(minWidth: minBoxWidth, alignment: .leading)
                                    .background {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.background)
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.gray.opacity(0.4))
                                        }
                                        .padding(.horizontal, -8)
                                        .padding(.vertical, -4)
                                    }
                                    .offset(x: boxOffset)
                                }
                            }
                        }
                    }
                }
            }
        }
        else {
            Text("You need iOS 16 or higher to support charts")
                .font(.title)
        }
        
    }
    
    @available(iOS 16.0, *)
    func ChartElementFinder(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy) -> Int? {
        let relXPos = location.x - geometry[proxy.plotAreaFrame].origin.x
        if let date = proxy.value(atX: relXPos) as Date? {
            var minDistance: TimeInterval = .infinity
            var index: Int? = nil
            for i in data.indices {
                let nthDataDistance = data[i].description.distance(to: date)
                if abs(nthDataDistance) < minDistance {
                    minDistance = abs(nthDataDistance)
                    index = i
                }
            }
            if let index {
                return index
            }
        }
        return nil
    }
}
