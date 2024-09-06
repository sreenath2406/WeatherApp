//
//  MockSearchLocationRepository.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//
import Foundation

struct MockSearchLocationRepository: SearchLocationRepositoryProtocol {
	var shouldReturnError = false
	var mockWeatherDetails: WeatherDetails?
	
	func getWeatherDetails(parameters: [String: String]) async throws -> WeatherDetails {
		if shouldReturnError {
			throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
		}
		return mockWeatherDetails ?? WeatherDetails(message: "Success", list: [])
	}
	
	func getLocationDetails(parameters: [String : String]) async throws -> [GeoLocation] {
		if shouldReturnError {
			throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
		}
		return [GeoLocation(name: "Austin", country: "US", state: "TX")]
	}
	
}
