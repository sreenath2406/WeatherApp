//
//  MockBaseURLProvider.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import Foundation
@testable import WeatherApp

class MockBaseURLProvider: BaseURLProvider {
	func baseURL() -> String {
		return "https://api.openweathermap.org"
	}
}
