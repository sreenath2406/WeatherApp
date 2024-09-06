//
//  SearchLocationRepository.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//
protocol SearchLocationRepositoryProtocol {
	func getWeatherDetails(parameters: [String: String]) async throws -> WeatherDetails
	func getLocationDetails(parameters: [String: String]) async throws -> [GeoLocation]
}

public struct SearchLocationRepository: SearchLocationRepositoryProtocol {
	private let source: SearchLocationRemoteDataSource
	
	init(baseURLProvder: BaseURLProvider) {
		source = SearchLocationRemoteDataSource(baseURLProvider: baseURLProvder)
	}
	
	func getWeatherDetails(parameters: [String: String]) async throws -> WeatherDetails {
		try await source.getSearchLocation(params: parameters)
	}
	
	func getLocationDetails(parameters: [String: String]) async throws -> [GeoLocation] {
		try await source.getLocationFromCoordinates(params: parameters)
	}
}
