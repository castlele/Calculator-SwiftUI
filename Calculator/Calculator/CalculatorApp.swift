//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Nikita Semenov on 12.01.2021.
//

import SwiftUI

@main
struct CalculatorApp: App {
	@StateObject private var settings = Settings()
    var body: some Scene {
        WindowGroup {
			ContentView().environmentObject(settings)
        }
    }
}
