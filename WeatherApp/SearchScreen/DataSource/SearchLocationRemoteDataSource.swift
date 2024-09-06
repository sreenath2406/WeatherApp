//
//  SearchLocationRemoteDataSource.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//
import Foundation

protocol SearchLocationRemoteDataSourceProtocol {
	func getSearchLocation(params: [String: String]) async throws -> WeatherDetails
	func getLocationFromCoordinates(params: [String : String]) async throws -> [GeoLocation]
}

struct SearchLocationRemoteDataSource: SearchLocationRemoteDataSourceProtocol {
	private let networking: NetworkingProtocol
	private let jsonDecoder: JSONDecoder
	
	init(baseURLProvider: BaseURLProvider) {
		self.networking = Networking(baseURLProvider: baseURLProvider)
		self.jsonDecoder = JSONDecoder()
		
		self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
	}
	
	func getSearchLocation(params: [String : String]) async throws -> WeatherDetails {
		let endpoint = SearchLocationResource.getWeather(parameters: params).endpoint
		let weatherDetails = try await networking.request(endpoint: endpoint, returnType: WeatherDetails.self, decoder: jsonDecoder)
		return weatherDetails
	}
	
	func getLocationFromCoordinates(params: [String : String]) async throws -> [GeoLocation] {
		let endpoint = SearchLocationResource.getLocationFromCooridnates(parameters: params).endpoint
		let locationDetails = try await networking.request(endpoint: endpoint, returnType: [GeoLocation].self, decoder: jsonDecoder)
		return locationDetails
	}
	
}
