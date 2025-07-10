//
//  CalculatorBrain.swift
//  CODECRAFT_AD_01( Calculator App )
//
//  Created by shashika theekshana on BE 2568-07-09.
//


import Foundation

enum Operation {
    case add, subtract, multiply, divide, none
}

struct CalculaterBrain {
    private var currentNumber: Double = 0
    private var previousNumber: Double = 0
    private var operation: Operation = .none
    private var isPerformingOperation = false
    
    mutating func setOperand(_ operand: Double) {
        currentNumber = operand
    }
    
    mutating func performOperation(_ operation: Operation) -> Double? {
        if !isPerformingOperation {
            previousNumber = currentNumber
            isPerformingOperation = true
            self.operation = operation
            return nil
        } else {
            switch self.operation {
            case .add:
                currentNumber = previousNumber + currentNumber
            case .subtract:
                currentNumber = previousNumber - currentNumber
            case .multiply:
                currentNumber = previousNumber * currentNumber
            case .divide:
                currentNumber = previousNumber / currentNumber
            case .none:
                break
            }
            self.operation = operation
            return currentNumber
        }
    }
    
    mutating func calculate() -> Double {
        switch operation {
        case .add:
            currentNumber = previousNumber + currentNumber
        case .subtract:
            currentNumber = previousNumber - currentNumber
        case .multiply:
            currentNumber = previousNumber * currentNumber
        case .divide:
            currentNumber = previousNumber / currentNumber
        case .none:
            break
        }
        isPerformingOperation = false
        return currentNumber
    }
    
    mutating func reset() {
        currentNumber = 0
        previousNumber = 0
        operation = .none
        isPerformingOperation = false
    }
    
    func getCurrentNumber() -> Double {
        return currentNumber
    }
}
