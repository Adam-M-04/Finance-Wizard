//
//  SwiftUIView.swift
//  
//
//  Created by Adam Mąka on 01/04/2023.
//

import SwiftUI

struct LineChartLegacy: View {
    var data: [DataStruct]
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height - 50
                
                let xStep = width / CGFloat(data.count - 1)
                let yStep = height / data.map { $0.value }.max()!
                
                Path { path in
                    for i in 0..<data.count {
                        let x = xStep * CGFloat(i)
                        let y = height - (yStep * data[i].value)
                        
                        if i == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    
                    }
                }
                .stroke(Color.white, lineWidth: 2)
            }
            .padding()
        }
    }
}

struct ChartLegacy_Previews: PreviewProvider {
    static var previews: some View {
        LineChartLegacy(data: [], title: "")
    }
}
