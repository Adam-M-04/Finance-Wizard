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
    @State private var income = 0
    @State private var expenses = [
        ExpenseObject(Name: "Housing", Value: 0),
        ExpenseObject(Name: "Food and groceries", Value: 0),
        ExpenseObject(Name: "Transportation", Value: 0),
        ExpenseObject(Name: "Entertainment", Value: 0),
        ExpenseObject(Name: "Education", Value: 0),
        ExpenseObject(Name: "Other", Value: 0)
    ]
    
    var body: some View {
        ZStack {
            GradientBackground()
                .ignoresSafeArea()
            
            List {
                Section(header: Text("Income")) {
                    InputListRow(inputValueBinding: self.$income, text: "Your monthly income", unit: "$", maxVal: 1000000, minVal: 1)
                }
                
                Section(header: Text("Expenses")) {
                    InputListRow(inputValueBinding: self.$expenses[0].Value, text: "Housing", unit: "$", maxVal: 1000000, minVal: 1)
                    InputListRow(inputValueBinding: self.$expenses[1].Value, text: "Food and groceries", unit: "$", maxVal: 1000000, minVal: 1)
                    InputListRow(inputValueBinding: self.$expenses[2].Value, text: "Transportation", unit: "$", maxVal: 1000000, minVal: 1)
                    InputListRow(inputValueBinding: self.$expenses[3].Value, text: "Entertainment", unit: "$", maxVal: 1000000, minVal: 1)
                    InputListRow(inputValueBinding: self.$expenses[4].Value, text: "Education", unit: "$", maxVal: 1000000, minVal: 1)
                    InputListRow(inputValueBinding: self.$expenses[5].Value, text: "Other", unit: "$", maxVal: 1000000, minVal: 1)
                }
                
                Section (header: Text("What do you spend the most on?")) {
                    SwiftChartHorizontal(data: getChartData(), title: "", unit: "%", lightOnly: false, barColors: [.green, .yellow, .red])
                        .padding(.vertical, 2)
                }
                
                Section(header: Text("Summary")) {
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
            .preferredColorScheme(.light)
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
            data.append(DataStruct(description: expense.Name, value: percent))
        }
        return data
    }
    
    func getSummaryText() -> String {
        let total = calculateRemaining()
        if (income == 0) {return "Enter your income"}
        if (total < 0) {
            return "You might want to slow down on your spending a bit, it looks like you're spending more than you're making."
        }
        if (Double(total) / Double(income) < 0.2) {
            return "Good job on saving some money, but it seems like you might not be allocating it effectively based on the 50/30/20 rule."
        }
        return "Excellent work! You are currently saving more than 20% of your income."
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
