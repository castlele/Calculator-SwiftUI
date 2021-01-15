//
//  Settings.swift
//  Calculator
//
//  Created by Nikita Semenov on 12.01.2021.
//

import Foundation

// Pull of themes 
enum Theme: String, CaseIterable, Codable {
	case classic, pink, blue, blank
}

// Pull of Font styles
enum FontStyle: String, CaseIterable, Codable {
	case bold, semibold, light, heavy, medium 
}

// Pull foreground colors
enum ForeGroundColorStyle: String, CaseIterable, Codable {
	case white, black, red, gray
}

class Settings: ObservableObject {

	@Published var theme: Theme = .classic	{
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(theme) {
				UserDefaults.standard.set(encoded, forKey: "theme")
			}
		}
	}

	@Published var font: FontStyle = .bold {
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(font) {
				UserDefaults.standard.set(encoded, forKey: "font")
			}
		}
	}
	
	@Published var fgColor: ForeGroundColorStyle = .white {
		didSet {
			let encoder = JSONEncoder()
			if let encoded = try? encoder.encode(fgColor) {
				UserDefaults.standard.set(encoded, forKey: "fgColor")
			}
		}
	}
}
