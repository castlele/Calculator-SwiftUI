//
//  ContentView.swift
//  Calculator
//
//  Created by Nikita Semenov on 12.01.2021.
//

import SwiftUI

// Which sheet to open
enum ActiveSheet {
	case tip, settings
}

struct BigTextView: View {
	
	var textSize: Int
	var fgColor: Color
	var number: String
	
	var body: some View {
		Text(number)
			.font(Font.system(size: CGFloat(textSize), weight: .medium))
			.foregroundColor(fgColor)
			.frame(maxHeight: 250)
	}
}

struct DeleteButton: View {

	let calc: Calculator
	let color: Color

	init(_ calc: Calculator, _ color: Color) {
		self.calc = calc
		self.color = color
	}

	var body: some View {
		Button(action: {
			if calc.number != "0" {
				if calc.number.count == 1 {
					calc.number = "0"
				} else {
					calc.number.removeLast()
				}
			}
		}, label: {
			Image(systemName: "delete.left")
				.foregroundColor(color)
				.font(.title)
		})
		.buttonStyle(PlainButtonStyle())
	}
}

struct ContentView: View {

	@ObservedObject var calc = Calculator()
	@EnvironmentObject var settings: Settings

	@State private var isSheet = false
	@State private var activeSheet: ActiveSheet = .settings
	
	// Decode theme from UserDefaults
	var theme: Theme {
		if let savedTheme = UserDefaults.standard.object(forKey: "theme") {
			let decoder = JSONDecoder()
			if let loadedTheme = try? decoder.decode(Theme.self, from: savedTheme as! Data) {
				return loadedTheme
			}
		}
		return .classic
	}

	// Decode font from UserDefaults
	var font: FontStyle {
		if let savedFont = UserDefaults.standard.object(forKey: "font") {
			let decoder = JSONDecoder()
			if let loadedFont = try? decoder.decode(FontStyle.self, from: savedFont as! Data) {
				return loadedFont
			}
		}
		return .bold
	}

	// Decode foreGround color from UserDefaults
	var fgColor: ForeGroundColorStyle {
		if let savedFG = UserDefaults.standard.object(forKey: "fgColor") as? Data {
			let decoder = JSONDecoder()
			if let loadedFG = try? decoder.decode(ForeGroundColorStyle.self, from: savedFG) {
				return loadedFG
			}
		}
		return .white
	}


    var body: some View {
		NavigationView {
			ZStack {

				generalBG
				
				VStack {
					HStack {
						Spacer()
						
						// Determine size of digits on the display depending on the amount of digits
						if calc.number.count > 5 && calc.number.count <= 11 {
							BigTextView(textSize: 50, fgColor: foreGround, number: calc.number)
							
						} else if calc.number.count <= 5 {
							BigTextView(textSize: 100, fgColor: foreGround, number: calc.number)
							
						} else if calc.number.count > 11 {
							BigTextView(textSize: 35, fgColor: foreGround, number: calc.number)
							
						} else {
							BigTextView(textSize: 50, fgColor: foreGround, number: calc.number)
						}
					}.padding(.top)
					
					// VStack with keyboard
					VStack(spacing: 2) {

						// First row
						HStack(spacing: 2) {
							ButtonView(bgColor: bgSpecial, fW: fontWeight, fColor: foreGround, sign: "C") { calc.clear() }
							
							ButtonView(bgColor: bgSpecial, fW: fontWeight, fColor: foreGround, sign: "plus.slash.minus") { calc.sign() }
							
							ButtonView(bgColor: bgSpecial, fW: fontWeight, fColor: foreGround, sign: "TIP") {
								isSheet = true
								activeSheet = .tip
							}
							
							ButtonView(bgColor: bgAction, fW: fontWeight, fColor: foreGround, sign: "divide") { calc.divide() }
						}
						
						// Second row
						HStack(spacing: 2) {
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "7") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "7"
								} else {
									if calc.number == "0" {
										calc.number = "7"
									} else {
										calc.number += "7"
									}
								}
							}
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "8") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "8"
								} else {
									if calc.number == "0" {
										calc.number = "8"
									} else {
										calc.number += "8"
									}
								}
							}
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "9") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "9"
								} else {
									if calc.number == "0" {
										calc.number = "9"
									} else {
										calc.number += "9"
									}
								}
							}
							
							ButtonView(bgColor: bgAction, fW: fontWeight, fColor: foreGround, sign: "multiply") { calc.multiply() }
						}
						
						// Third row
						HStack(spacing: 2) {
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "4") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "4"
								} else {
									if calc.number == "0" {
										calc.number = "4"
									} else {
										calc.number += "4"
									}
								}
						   }
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "5") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "5"
								} else {
									if calc.number == "0" {
										calc.number = "5"
									} else {
										calc.number += "5"
									}
								}
						   }
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "6") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "6"
								} else {
									if calc.number == "0" {
										calc.number = "6"
									} else {
										calc.number += "6"
									}
								}
						   }
							
							ButtonView(bgColor: bgAction, fW: fontWeight, fColor: foreGround, sign: "minus") { calc.subtract() }
						}
						
						// Fourth row
						HStack(spacing: 2) {
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "1") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "1"
								} else {
									if calc.number == "0" {
										calc.number = "1"
									} else {
										calc.number += "1"
									}
								}
						   }
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "2") {
								
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "2"
								} else {
									if calc.number == "0" {
										calc.number = "2"
									} else {
										calc.number += "2"
									}
								}
							}
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: "3") {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
									calc.number = "3"
								} else {
									if calc.number == "0" {
										calc.number = "3"
									} else {
										calc.number += "3"
									}
								}
						   }
							
							ButtonView(bgColor: bgAction, fW: fontWeight, fColor: foreGround, sign: "plus") { calc.add() }
						}
						
						// Fifth row
						HStack(spacing: 2) {

							// Zero button view
							Button(action: {
								if calc.bufferOfAct != nil && calc.bufferOfNum == calc.number {
							   		calc.number = "0"
								} else {
							   		if calc.number == "0" {
										calc.number = "0"
									} else {
										calc.number += "0"
									}
								}
						
							}, label: {
								Text("0")
									.fontWeight(fontWeight)
							})
							.font(.title)
							.foregroundColor(foreGround)
							.frame(width: 175, height: 80)
							.background(bgNumbers)
							.clipShape(Capsule())
							
							ButtonView(bgColor: bgNumbers, fW: fontWeight, fColor: foreGround, sign: ",") { calc.floatPoint() }
							
							ButtonView(bgColor: bgAction, fW: fontWeight, fColor: foreGround, sign: "equal") { calc.equal() }
						}
					}
					.frame(maxHeight: 420)
					.padding()
					.padding(.bottom)
				}
			}
			.ignoresSafeArea()
			.navigationBarItems(trailing: DeleteButton(calc, foreGround))
			.onLongPressGesture(minimumDuration: 0.25) {
				isSheet = true
				activeSheet = .settings
			}
			.sheet(isPresented: $isSheet) {
				switch activeSheet {
					case .tip:
						TipView(number: calc.number, bgColor: generalBG)
					case .settings:
						SettingsView(isPresented: $isSheet)
				}
			}
		}
    }
}

// Extension with elements of customization 
extension ContentView {
	
	var generalBG: Color {
		switch theme {
			case .classic:
				return Color("ClassicBG")
			case .pink:
				return Color("PinkBG")
			case .blue:
				return Color("BlueBG")
			case .blank:
				return Color("BlankBG")
		}
	}
	
	var bgAction: Color {
		switch theme {
			case .classic:
				return Color("ClassicAct")
			case .pink:
				return Color("PinkAct")
			case .blue:
				return Color("BlueAct")
			case .blank:
				return Color("BlankAct")
		}
	}

	var bgSpecial: Color {
		switch theme {
			case .classic:
				return  Color("ClassicSpecial")
			case .pink:
				return Color("PinkSpecial")
			case .blue:
				return Color("BlueSpecial")
			case .blank:
				return Color("BlankSpecial")
		}
	}

	var bgNumbers: Color {
		switch theme {
			case .classic:
				return Color("ClassicNum")
			case .pink:
				return Color("PinkNum")
			case .blue:
				return Color("BlueNum")
			case .blank:
				return Color("BlankNum")
		}
	}

	var fontWeight: Font.Weight {
		switch font {
			case .bold:
				return Font.Weight.bold
			case .semibold:
				return Font.Weight.semibold
			case .light:
				return Font.Weight.light
			case .heavy:
				return Font.Weight.heavy
			case .medium:
				return Font.Weight.medium
		}
	}

	var foreGround: Color {
		switch fgColor {
			case .white:
				return Color.white
			case .black:
				return Color.black
			case .red:
				return Color.red
			case .gray:
				return Color.gray
		}	
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView().environmentObject(Settings())
    }
}
