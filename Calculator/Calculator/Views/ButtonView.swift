//
//  ButtonView.swift
//  Calculator
//
//  Created by Nikita Semenov on 12.01.2021.
//

import SwiftUI

// View of single number button in calculator
struct ButtonView: View {
	
	var backgroundColor: Color
	var fontWeight: Font.Weight?
	var fontColor: Color
	var sign = ""
	var action: () -> Void
	
	init(bgColor: Color, fW: Font.Weight?, fColor: Color, sign: String, action: @escaping () -> Void) {
		backgroundColor = bgColor
		fontWeight = fW
		fontColor = fColor
		self.action = action
		self.sign = sign
		
	}
	
    var body: some View {
		GeometryReader { geom in
			Button(action: {
				action()
				
			}, label: {
				if sign == "TIP" || sign == "," || sign == "C" {
					Text(sign)
						.fontWeight(fontWeight)
				} else if let _ = Int(sign) {
					Text(sign)
						.fontWeight(fontWeight)
				} else if let _ = Double(sign) {
					Text(sign)
						.fontWeight(fontWeight)
				} else {
					Image(systemName: sign)
				}
			})
			.font(.title)
			.foregroundColor(fontColor)
			.frame(width: geom.size.width, height: 80)
			.background(backgroundColor)
			.clipShape(Capsule())
		}
	}
}

struct ButtonView_Previews: PreviewProvider {
	static var previews: some View {
		ButtonView(bgColor: .orange, fW: .semibold, fColor: .white, sign: "equal", action: { })
		
	}
}

