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
    @State private var returnRate = 10
    @State private var timespan = 5
    @State private var selectedElementIndex: Int?
    @State private var showingBottomSheet = false
    @State private var renderedChartImage: Image?
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
                .toolbar {
                    if let renderedChartImage {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            ShareLink(item: renderedChartImage, preview: SharePreview("Investment simulation", image: renderedChartImage))
                        }
                    }
                }
            
            List {
                Section(header: Text("Parameters").foregroundColor(.white)) {
                    InputListRow(inputValueBinding: self.$monthlyInvestment, text: "Monthly investment", unit: "$", maxVal: 20000, minVal: 1)
                        .onChange(of: monthlyInvestment) { newVal in
                            renderChartImage(delay: 0.2)
                        }
                    InputListRow(inputValueBinding: self.$returnRate, text: "Annual return rate", unit: "%", maxVal: 50, minVal: 1)
                        .onChange(of: returnRate) { newVal in
                            renderChartImage(delay: 0.2)
                        }
                    
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
                            timespan = newValue
                            selectedElementIndex = nil
                        }
                        renderChartImage(delay: 0.5)
                    }
                }
                
                Section (header: Text("Simulation").foregroundColor(.white)) {
                    SwiftChartInvestment(selectedElementIndex: $selectedElementIndex, data: getChartData(), baseData: getBaseChartData(), barColors: [.blue, .red])
                        .padding(.vertical, 2)
                        .animation(.easeInOut(duration: 0.5), value: timespan)
                        .onAppear {
                            renderChartImage(delay: 0)
                        }
                }
                
                
                Section(header: Text("Summary").foregroundColor(.white)) {
                    let data = [
                        (name: "Idle money in bank", data: getBaseChartData()),
                        (name: "Invested money", data: getChartData())
                    ]
                    let chartData = data[1].data
                    let chartBaseData = data[0].data
                    

                    HStack {
                        Text("Savings after \(timespan) years:")
                            .font(.callout)
                            .animation(.linear)
                        Spacer()
                        Text("$\(Int(chartData.last!.value + chartBaseData.last!.value))")
                            .font(.callout)
                            .animation(.linear)
                    }
                    
                    HStack {
                        Text("Investment gains:")
                            .font(.callout)
                        Spacer()
                        Text("$\(Int(chartData.last!.value))")
                            .font(.callout)
                            .foregroundColor(.green)
                            .animation(.linear)
                    }
                    
                    HStack {
                        Text("About return rates:")
                            .font(.callout)
                            .foregroundColor(.blue)
                        Spacer()
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                    }
                    .onTapGesture {
                        showingBottomSheet.toggle()
                    }
                    .sheet(isPresented: $showingBottomSheet) {
                        VStack (alignment: .leading) {
                            Text("Annual return rates")
                                .font(.title)
                                .padding(.bottom)
                            
                            Text("Return rates are a significant variable in investing, but for the purpose of calculations, we can assume an average of 10% rate of return when investing in the stock market.")
                                .padding(.bottom)
                                //.frame(minHeight: 120)
                            
                            Text("For example, the average annual returns of the S&P 500 over the last 100 years have been approximately 10.3%.")
                                .padding(.bottom)
                            
                            Text("S&P 500 is a stock market index tracking the stock performance of 500 of the largest companies listed on stock exchanges in the United States.")
                                .foregroundColor(.secondary)
                                .italic()
                        }
                        .padding()
                        .presentationDetents([.height(500)])
                    }
                }
                
            }
            .scrollContentBackground(.hidden)
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
    
    func renderChartImage(delay: Double) -> Void {
        let data = getChartData()
        let baseData = getBaseChartData()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let view = VStack {
                Text("Investment simulation")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("(Monthly: $\(monthlyInvestment) / Return reate: \(returnRate)%)")
                    .font(.callout)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                SwiftChartInvestment(selectedElementIndex: $selectedElementIndex, data: getChartData(), baseData: getBaseChartData(), barColors: [.blue, .red])
                        .frame(width: 400)
                        .padding()
                
                HStack {
                    Text("Savings after \(timespan) years:")
                        .font(.callout)
                    Spacer()
                    Text("$\(Int( data.last!.value + baseData.last!.value))")
                        .font(.callout)
                }
                .padding(.horizontal)
                .padding(.bottom, 2)
                HStack {
                    Text("Investment gains:")
                        .font(.callout)
                    Spacer()
                    Text("$\(Int(data.last!.value))")
                        .font(.callout)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
                .background(Color.white)
                
            let renderer = ImageRenderer(content: view)
            renderer.scale = 2
            if let image = renderer.cgImage {
                renderedChartImage = Image(decorative: image, scale: 1.0)
            }
        }
    }
}

@available(iOS 16.0, *)
struct InvestingSimulation_Previews: PreviewProvider {
    static var previews: some View {
        InvestingSimulation()
    }
}
