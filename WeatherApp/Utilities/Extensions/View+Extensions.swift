//
//  View+Extensions.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//
import SwiftUI

extension View {
	func listBackgroundColor(_ color: Color) -> some View {
		scrollContentBackground(.hidden)
			.background(color.edgesIgnoringSafeArea(.all))
	}
}
