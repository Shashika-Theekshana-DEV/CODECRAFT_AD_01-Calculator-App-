//
//  CalculatorViewModel.swift
//  CODECRAFT_AD_01(Calculator App)
//
//  Created by shashika theekshana on BE 2568-07-09.
//

import Foundation

class CalculatorViewModel: ObservableObject {
    @Published var displayText: String = "0"
    @Published var operationText: String = ""
    
    private var model = CalculaterBrain()
    private var isUserTyping = false
    private var displayValue: Double {
        get {
            return Double(displayText) ?? 0
        }
        set {
            displayText = formatNumber(newValue)
        }
    }
    
    private func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
    
    func digitPressed(_ digit: String) {
        if isUserTyping {
            if digit == "." && displayText.contains(".") {
                return
            }
            displayText += digit
        } else {
            displayText = digit == "." ? "0." : digit
            isUserTyping = true
        }
        operationText = ""
    }
    
    func operationPressed(_ operation: Operation) {
        if operationText.isEmpty && displayValue == 0 {
            return
        }
        
        if isUserTyping {
            model.setOperand(displayValue)
            isUserTyping = false
        }
        
        switch operation {
        case .add: operationText = "+"
        case .subtract: operationText = "-"
        case .multiply: operationText = "×"
        case .divide:
            if displayValue == 0 {
                displayText = "Error"
                operationText = ""
                return
            }
            operationText = "÷"
        case .none: operationText = ""
        }
        
        if let result = model.performOperation(operation) {
            displayValue = result
        }
    }
    
    func calculate() {
        operationText = ""
        if isUserTyping {
            model.setOperand(displayValue)
            isUserTyping = false
        }
        displayValue = model.calculate()
    }
    
    func reset() {
        model.reset()
        displayText = "0"
        operationText = ""
        isUserTyping = false
    }
}
