//
//  ExpensesTracking.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 02/04/2023.
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
struct ExpensesTracking: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedPickerIndex = 0
    @State private var income = 0
    @State private var expenses = [
        ExpenseObject(Name: "Housing", Value: 0),
        ExpenseObject(Name: "Food and groceries", Value: 0),
        ExpenseObject(Name: "Transportation", Value: 0),
        ExpenseObject(Name: "Entertainment", Value: 0),
        ExpenseObject(Name: "Education", Value: 0),
        ExpenseObject(Name: "Other", Value: 0)
    ]
    @State private var renderedChartImage: Image?
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
                .toolbar {
                    if let renderedChartImage {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            ShareLink(item: renderedChartImage, preview: SharePreview("Monthly expenses", image: renderedChartImage))
                        }
                    }
                }
            
            List {
                Section(header: Text("Income").foregroundColor(.white)) {
                    InputListRow(inputValueBinding: self.$income, text: "Your monthly income", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: income) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                }
                
                Section(header: Text("Expenses").foregroundColor(.white)) {
                    InputListRow(inputValueBinding: self.$expenses[0].Value, text: "Housing", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[0].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                    InputListRow(inputValueBinding: self.$expenses[1].Value, text: "Food and groceries", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[1].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                    InputListRow(inputValueBinding: self.$expenses[2].Value, text: "Transportation", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[2].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                    InputListRow(inputValueBinding: self.$expenses[3].Value, text: "Entertainment", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[3].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                    InputListRow(inputValueBinding: self.$expenses[4].Value, text: "Education", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[4].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                    InputListRow(inputValueBinding: self.$expenses[5].Value, text: "Other", unit: "$", maxVal: 1000000, minVal: 1)
                        .onChange(of: self.expenses[5].Value) { newVal in
                            renderChartImage(delay: 0.5)
                        }
                }
                
                Section (header: Text("What do you spend the most on?").foregroundColor(.white)) {
                    Picker("Investment letngth", selection: $selectedPickerIndex) {
                        Text("%").tag(0)
                        Text("$").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 5)
                    .onChange(of: self.selectedPickerIndex) { newVal in
                        renderChartImage(delay: 0.2)
                    }
                    
                    SwiftChartExpenses(data: getChartData(), unit: selectedPickerIndex == 0 ? "%" : "$", lightOnly: false, barColors: [.green, .yellow, .red])
                        .padding(.vertical, 2)
                        .animation(.easeInOut(duration: 0.5), value: selectedPickerIndex)
                        .onAppear {
                            renderChartImage(delay: 0)
                        }
                }
                
                Section(header: Text("Summary").foregroundColor(.white)) {
                    HStack {
                        Text("Remaining")
                        Spacer()
                        Text(String(calculateRemaining()) + "$")
                            .padding(0)
                            .foregroundColor(determineColor())
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    VStack {
                        Text(getSummaryText())
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .frame(minHeight: 50, maxHeight: .infinity)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    func calculateRemaining() -> Int {
        var total = income
        for expense in expenses {
            total -= expense.Value
        }
        return total
    }
    
    func determineColor() -> Color {
        return calculateRemaining() < 0 ? .red : .green
    }
    
    func getChartData() -> [DataStruct] {
        let total = abs(calculateRemaining() - income)
        
        var data: [DataStruct] = []
        for expense in expenses {
            let percent = total == 0 ? 0 : Double(expense.Value) / Double(total) * 100
            data.append(DataStruct(description: expense.Name, value: selectedPickerIndex == 0 ? percent : Double(expense.Value)))
        }
        return data
    }
    
    func getSummaryText() -> String {
        let total = calculateRemaining()
        if (income == 0) {return "Enter your income"}
        if (total <= 0) {
            return "You might want to slow down on your spending a bit, it looks like you spend more than you earn."
        }
        if (Double(total) / Double(income) < 0.2) {
            return "Good job on saving some money, but you might not be allocating it efficiently based on the 50/30/20 rule."
        }
        return "Well done! You are currently saving at least 20% of your income."
    }
    
    func renderChartImage(delay: Double) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let view = VStack {
                Text("Monthly expenses")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                SwiftChartExpenses(data: getChartData(), unit: selectedPickerIndex == 0 ? "%" : "$", lightOnly: false, barColors: [.green, .yellow, .red])
                    .frame(width: 400)
                    .padding()
                
                HStack {
                    Text("Income: ")
                        .font(.callout)
                    Spacer()
                    Text("$\(Int(income))")
                        .font(.callout)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                HStack {
                    let savings = calculateRemaining()
                    Text("Savings: ")
                        .font(.callout)
                    Spacer()
                    Text("$\(Int(savings))")
                        .font(.callout)
                        .foregroundColor(savings < 0 ? .red : .green)
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

struct ExpenseObject {
    var Name: String
    var Value: Int
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


@available(iOS 16.0, *)
struct ExpensesTracking_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesTracking()
    }
}
