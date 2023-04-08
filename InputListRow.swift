//
//  ExpensesRow.swift
//  Finance Wizard
//
//  Created by Adam Mąka on 03/04/2023.
//

import Foundation
import SwiftUI

struct InputListRow: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding public var inputValueBinding: Int
    @State public var inputValue: Int = 0
    let text: String
    let unit: String
    let maxVal: Int
    let minVal: Int
    
    var body: some View {
        HStack {
            Text(text + ":")
            Spacer()
            TextField("", value: $inputValue, format: .number)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .textFieldStyle(.roundedBorder)
                .frame(width: 100)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .onChange(of: inputValue) { newValue in
                    let clampedVal = max(minVal, min(maxVal, newValue))
                    withAnimation(.easeInOut) {
                        inputValueBinding = clampedVal
                    }
                    inputValue = inputValueBinding
                }
        
            Text(unit)
                .padding(0)
                .frame(minWidth: 20)
        }
        .padding(.vertical, 1.1)
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .onAppear {
            inputValue = inputValueBinding
        }
    }
}
