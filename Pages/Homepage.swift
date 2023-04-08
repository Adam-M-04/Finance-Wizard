//
//  Homepage.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 31/03/2023.
//

import SwiftUI
import Combine

struct Homepage: View {
    @State private var stockData: [DataStructureVertical] = stockValues
    @Binding var currentTab: Int
    @Binding var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    var body: some View {
        VStack {
            VStack {
                Text("💸")
                    .font(.system(size: 100))
                    .padding(-10)
            
                Text("Welcome to")
                    .padding(.top)
                Text("Finance Wizard")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Your guide to the world of finance")
                    .padding(.top, 0)
                    .padding(.bottom)
            }
            .scaleEffect(1.2)
            
            SwiftChartStock(data: stockData)
                .padding(.top, 30)
                .padding(.horizontal, 20)
                .colorScheme(.dark)
        }
        .onReceive(timer) { _ in
            if (currentTab == 1) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    stockData.append(randomData())
                    stockData.remove(at: 0)
                }
            }
        }
    }
    
    private func randomData() -> DataStructureVertical {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: stockData.last!.description)!
        let lastVal = stockData.last!.value
        let value = abs(Double.random(in: (lastVal-4)...(lastVal+5)))
        
        return DataStructureVertical(description: date, value: value)
    }
}


