//
//  InvestingSimulation.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 04/04/2023.
//

import SwiftUI

@available(iOS 16.0, *)
struct InvestingSimulation: View {
    @State private var monthlyInvestment = 100
    @State private var returnRate = 6
    @State private var timespan = 5
    @State private var selectedElementIndex: Int?
    @State private var showingBottomSheet = false
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
            
            List {
                Section(header: Text("Parameters")) {
                    InputListRow(inputValueBinding: self.$monthlyInvestment, text: "Monthly investment", unit: "$", maxVal: 20000, minVal: 1)
                    InputListRow(inputValueBinding: self.$returnRate, text: "Annual return rate", unit: "%", maxVal: 50, minVal: 1)
                    
                    Picker("Investment letngth", selection: $timespan) {
                        Text("5 years").tag(5)
                        Text("10 years").tag(10)
                        Text("20 years").tag(20)
                        Text("40 years").tag(40)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 5)
                    .onChange(of: timespan) { newValue in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            timespan = 40
                            timespan = newValue
                            selectedElementIndex = nil
                        }
                    }
                }
                
                Section (header: Text("Simulation")) {
                    SwiftChartInvestment(selectedElementIndex: $selectedElementIndex, data: getChartData(), baseData: getBaseChartData(), unit: "$", ColorScheme: .light, barColors: [.blue, .red])
                        .padding(.vertical, 2)
                        .animation(.easeInOut(duration: 0.5), value: timespan)
                }
                
                Section(header: Text("Summary")) {
                    let data = [
                        (name: "Idle money in bank", data: getBaseChartData()),
                        (name: "Invested money", data: getChartData())
                    ]
                    let chartData = data[1].data
                    let chartBaseData = data[0].data
                    

                    HStack {
                        Text("Savings after \(timespan) years:")
                            .font(.callout)
                        Spacer()
                        Text("$\(Int(chartData.last!.value + chartBaseData.last!.value))")
                            .font(.callout)
                    }
                    .foregroundColor(.black)
                    
                    HStack {
                        Text("Investment gains:")
                            .font(.callout)
                        Spacer()
                        Text("$\(Int(chartData.last!.value))")
                            .font(.callout)
                            .foregroundColor(.green)
                    }
                    .foregroundColor(.black)
                    
                    HStack {
                        Text("About return rates:")
                            .font(.callout)
                        Spacer()
                        Image(systemName: "info.circle")
                    }
                    .onTapGesture {
                        showingBottomSheet.toggle()
                    }
                    .sheet(isPresented: $showingBottomSheet) {
                        VStack (alignment: .leading) {
                            Text("Return rates are a significant variable in investing, but for the purpose of calculations, we can consider the following average return rates:")
                            VStack (alignment: .leading) {
                                HStack {
                                    Text("•")
                                        .font(.title)
                                    Text("Long-term government bonds:")
                                        .font(.body)
                                    Text("5% - 6%")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                HStack {
                                    Text("•")
                                        .font(.title)
                                    Text("Large stocks from stock market:")
                                        .font(.body)
                                    Text("~10%")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                .padding(.bottom, 5)
                            }
                            
                            Text("For example, the price returns of the S&P 500 over the last 100 years have been approximately 10.3%.")
                                .padding(.bottom)
                            
                            Text("S&P 500 is a stock market index tracking the stock performance of 500 of the largest companies listed on stock exchanges in the United States.")
                        }
                        .padding()
                        .presentationDetents([.medium])
                    }
                    .foregroundColor(.black)
                }
                
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
            .preferredColorScheme(.light)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    func getChartData() -> [DataStructureVertical] {
        var data: [DataStructureVertical] = []
        var current = 0
        let annualReturnRate: Double = Double(returnRate) / Double(100) + 1
        let currentYear = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
        var i = 0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        while (i < timespan) {
            current += 12 * monthlyInvestment
            current = Int(annualReturnRate * Double(current))
            
            i += 1
            if (timespan != 40 || i % 2 == 0) {
                data.append(DataStructureVertical(description: formatter.date(from: String(currentYear + i))!, value: Double(current - calculateBaseInvestmentValue(year: i))))
            }
        }
    
        return data
    }
    
    func getBaseChartData() -> [DataStructureVertical] {
        var data: [DataStructureVertical] = []
        let currentYear = Calendar(identifier: .gregorian).dateComponents([.year], from: .now).year!
        var i = 1
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        while (i <= timespan) {
            if (timespan != 40 || i % 2 == 0) {
                data.append(DataStructureVertical(description: formatter.date(from: String(currentYear + i))!, value: Double(calculateBaseInvestmentValue(year: i))))
            }
            i += 1
        }
        
        return data
    }
    
    func calculateBaseInvestmentValue(year: Int) -> Int {
        return monthlyInvestment * 12 * year
    }
}

@available(iOS 16.0, *)
struct InvestingSimulation_Previews: PreviewProvider {
    static var previews: some View {
        InvestingSimulation()
    }
}
