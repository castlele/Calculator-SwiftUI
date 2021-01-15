//
//  Calculator.swift
//  Calculator
//
//  Created by Nikita Semenov on 12.01.2021.
//

import Foundation

// Type of number on the display
enum NumberType {
	case float, int
}

// Type of action to perform under numbers
enum ActionType {
	case mul, div, sub, add
}

class Calculator: ObservableObject {

	// Number shown on the display and its type
	@Published var number = "0"
	var numberType: NumberType = .int

	// Number in the buffer and its type
	var bufferOfNum = "0"
	var bufferType: NumberType = .int

	// Action to perform 
	var bufferOfAct: ActionType? = nil

	// Limit of numbers on the display
	let limit = 16

	// Current amount of digits in the number on the display
	var count: Int { number.count }
	
	// Make number on the display of .float type
	func floatPoint() {
		if count < limit {
			number += "."
			numberType = .float
		}
	}
	
	// Make number negative or positive
	func sign() {
		if count < limit {
			number = "-\(number)"
		}
	}
	
	// Clear of buffers and current number
	func clear() {
		number = "0"
		bufferOfNum = "0"
		bufferOfAct = nil
		bufferType = .int
		numberType = .int
	}
	
	func add() {
		bufferOfNum = number
		bufferType = numberType
		bufferOfAct = .add
	}
	
	func subtract() {
		bufferOfNum = number
		bufferType = numberType
		bufferOfAct = .sub
	}
	
	func multiply() {
		bufferOfNum = number
		bufferType = numberType
		bufferOfAct = .mul
	}
	
	func divide() {
		bufferOfNum = number
		bufferType = numberType
		bufferOfAct = .div
	}
	
	func equal() {
		if let act = bufferOfAct {
			switch act {
				case .add:
					addition()
				case .mul:
					multiplication()
				case .sub:
					subtraction()
				case .div:
					division()
			}
		}
	}

	private func addition() {
		switch numberType {
			case .int:
				switch bufferType {
					case .int:
						number = String(Int(bufferOfNum)! + Int(number)!)
					case .float:
						number = String(Double(bufferOfNum)! + Double(number)!)
				}
				
			case .float:
				number = String(Double(bufferOfNum)! + Double(number)!)
		}
	}

	private func multiplication() {
		switch numberType {
			case .int:
				switch bufferType {
					case .int:
						number = String(Int(bufferOfNum)! * Int(number)!)
					case .float:
						number = String(Double(bufferOfNum)! * Double(number)!)
				}
				
			case .float:
				number = String(Double(bufferOfNum)! * Double(number)!)
		}
	}

	private func subtraction() {
		switch numberType {
			case .int:
				switch bufferType {
					case .int:
						number = String(Int(bufferOfNum)! - Int(number)!)
					case .float:
						number = String(Double(bufferOfNum)! - Double(number)!)
				}
				
			case .float:
				number = String(Double(bufferOfNum)! - Double(number)!)
		}
	}

	private func division() {
		guard number != "0" else {
			return
		}
		
		switch numberType {
			case .int:
				switch bufferType {
					case .int:
						if Int(bufferOfNum)! < Int(number)! {
							number = String(Double(bufferOfNum)! / Double(number)!)
						} else {
							number = String(Int(bufferOfNum)! / Int(number)!)
						}
						
					case .float:
						number = String(Double(bufferOfNum)! / Double(number)!)
				}
				
			case .float:
				number = String(Double(bufferOfNum)! / Double(number)!)
		}
	}
}
