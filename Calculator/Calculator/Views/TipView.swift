//
//  TipView.swift
//  Calculator
//
//  Created by Nikita Semenov on 13.01.2021.
//

import SwiftUI

// Group for two Views in the VStack
struct ViewGroup<V1: View, V2: View>: View {

	var heading: V1
	var content: V2
	
	var body: some View {
		VStack {
			heading
			content
		}
		.padding()
		.foregroundColor(.white)
		.frame(maxWidth: .infinity, maxHeight: 80)
		.background(Color("ClassicSpecial"))
		.clipShape(Capsule())
	}
}

struct Title: View {
	
	var text: String
	
	init(_ text: String) { self.text = text }
	
	var body: some View {
		Text(text)
			.font(.headline)
			.foregroundColor(.white)
	}
}

struct TipView: View {
	
	@Environment(\.presentationMode) var presentationMode

	// Current number on the display
	var number: String
	// Background color of current theme
	var bgColor: Color
	
	// Tip amount in percents 
	@State private var tipAmount = 1
	// Amount of people who will split the number
	@State private var people = 1

	// Number + tip
	var total: Double {
		return ((Double(tipAmount) * Double(number)!) / 100) + (Double(number)!)
	}
	
	// How much does every person should pay
	var each: Double {
		return total / Double(people)
	}

    var body: some View {
		NavigationView {

			ZStack {

				bgColor.ignoresSafeArea()

				VStack {
					// Display current number on the display
					HStack {
						Text("\(number)")
							.font(.system(size: 60))
							.fontWeight(.bold)
							.foregroundColor(.white)
							.padding(.leading)
						
						Spacer()
					}

					// View for changing tip amount
					 ViewGroup(heading: Title("Tip amount"),
							   content: Stepper("\(tipAmount)%", onIncrement: {
								if tipAmount < 100 {
									tipAmount += 1
								}
							   }, onDecrement: {
								if tipAmount > 1 {
									tipAmount -= 1
								}
							}))
					// VIew for changing amount of people
					ViewGroup(heading: Title("Amount of people"),
							  content: Stepper(value: $people, in: 1...50, step: 1) { Text("\(people)")})
					
					// View with total number and number for single person
					HStack {
						Spacer()
						
						VStack {
							Text("\(total, specifier: "%g") total")
								.font(.title)
								.fontWeight(.semibold)

							Text("\(each, specifier: "%g") each")
								.font(.title2)
								.fontWeight(.semibold)
						}
						.foregroundColor(.white)
						.padding()
					}

					Spacer()
				}
			}
			.navigationBarItems(trailing:
				Button(action: {
					presentationMode.wrappedValue.dismiss()
				}, label: {
					Image(systemName: "multiply")
						.font(.title)
						.foregroundColor(.gray)
				})
			)
		}
	}
}

//struct TipView_Previews: PreviewProvider {
//	struct Mock {
//		var num = 9
//	}
//  static var previews: some View {
//	TipView(bgColor: Color("ClassicBG"))
//  }
//}
