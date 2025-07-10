//
//  MainCalculatorView.swift
//  CODECRAFT_AD_01( Calculator App )
//
//  Created by shashika theekshana on BE 2568-07-09.
//


import SwiftUI

struct MainCalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
            
                HStack {
                    Spacer()
                    Text(viewModel.displayText)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                        .padding()
                }
                .padding(.horizontal)
                
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button) {
                                self.buttonTapped(button)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    private func buttonTapped(_ button: CalculatorButton) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            viewModel.digitPressed(button.title)
        case .add:
            viewModel.operationPressed(.add)
        case .subtract:
            viewModel.operationPressed(.subtract)
        case .multiply:
            viewModel.operationPressed(.multiply)
        case .divide:
            viewModel.operationPressed(.divide)
        case .equals:
            viewModel.calculate()
        case .clear:
            viewModel.reset()
        case .negative, .percent:
            break
        }
    }
}

enum CalculatorButton: String, Hashable {
    case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case decimal = "."
    case equals = "=", add = "+", subtract = "-", multiply = "×", divide = "÷"
    case clear = "AC", negative = "+/-", percent = "%"
    
    var title: String {
        return self.rawValue
    }
    
    var backgroundColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color(.lightGray)
        case .divide, .multiply, .subtract, .add, .equals:
            return Color(.orange)
        default:
            return Color(.darkGray)
        }
    }
}

struct CalculatorButtonView: View {
    var button: CalculatorButton
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: buttonWidth(button), height: buttonHeight())
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(buttonWidth(button)/2)
        }
    }
    
    private func buttonWidth(_ button: CalculatorButton) -> CGFloat {
        return button == .zero ? (UIScreen.main.bounds.width - 5*12) / 2 : (UIScreen.main.bounds.width - 5*12) / 4
    }
    
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5*12) / 4
    }
}


