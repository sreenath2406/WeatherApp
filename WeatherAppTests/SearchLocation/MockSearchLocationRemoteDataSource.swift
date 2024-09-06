//
//  MockSearchLocation.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import Foundation
@testable import WeatherApp

class MockSearchLocationRemoteDataSource: SearchLocationRemoteDataSourceProtocol {
	var weatherDetails: WeatherDetails?
	var geoLocation: [GeoLocation]?
	var shouldThrowError: Bool = false
	
	func getSearchLocation(params: [String : String]) async throws -> WeatherDetails {
		guard !shouldThrowError else { throw NetworkingError.decodingFailed }
		guard let weatherDetails = weatherDetails else { throw NetworkingError.decodingFailed }
		return weatherDetails
	}

	func getLocationFromCoordinates(params: [String : String]) async throws -> [GeoLocation] {
		guard !shouldThrowError else { throw NetworkingError.decodingFailed }
		guard let geoLocation = geoLocation else { throw NetworkingError.decodingFailed }
		return geoLocation
	}
}
