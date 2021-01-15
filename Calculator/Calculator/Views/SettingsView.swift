//
//  SettingsView.swift
//  Calculator
//
//  Created by Nikita Semenov on 13.01.2021.
//

import SwiftUI

struct SettingsView: View {
	
	@EnvironmentObject var settings: Settings
	@Binding var isPresented: Bool

    var body: some View {
    	NavigationView {
			Form {

				// Theme Picker
				Section(header: Text("Theme")) {
					Picker("", selection: $settings.theme) {
						ForEach(Theme.allCases, id: \.self) { theme in
							Text("\(theme.rawValue)")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}
				
				// Foreground picker
				Section(header: Text("Fore Ground Color")) {
					Picker("", selection: $settings.fgColor) {
						ForEach(ForeGroundColorStyle.allCases, id: \.self) { color in
							Text("\(color.rawValue)")
						}
					}
					.pickerStyle(SegmentedPickerStyle())
				}

				// Font style picker
    			Section(header: Text("Font")) {
    				Picker("", selection: $settings.font) {
						ForEach(FontStyle.allCases, id: \.self) { font in
							Text("\(font.rawValue)")
						}
					}
					.pickerStyle(WheelPickerStyle())
    			}
			}
    		.navigationBarTitle("Settings")
    		.navigationBarItems(trailing: 
    			Button(action: {
    				isPresented = false
				}, label: {
					Image(systemName: "multiply")
						.font(.title)
						.foregroundColor(.gray)
				})
    		)
    	}
    }
}

//struct SettingsView_Previews: PreviewProvider {
//	@State var isPresented = true
//    static var previews: some View {
//		SettingsView(isPresented: $isPresented)
//    }
//}
