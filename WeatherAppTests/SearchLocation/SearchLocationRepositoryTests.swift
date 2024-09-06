//
//  SearchLocationRepositoryTests.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import XCTest
@testable import WeatherApp

class SearchLocationRepositoryTests: XCTestCase {
	var repository: SearchLocationRepository!
	var mockDataSource: MockSearchLocationRemoteDataSource!
	
	override func setUp() {
		super.setUp()
		mockDataSource = MockSearchLocationRemoteDataSource()
		repository = SearchLocationRepository(baseURLProvder: MockBaseURLProvider())
	}
	
	override func tearDown() {
		repository = nil
		mockDataSource = nil
		
		super.tearDown()
	}
	
	func testGetWeatherDetails() async {
		let details = Details(temp: 23.12,
							  feelsLike: 25.14,
							  tempMin: 10.1,
							  tempMax: 12.2,
							  pressure: 12,
							  humidity: 21,
							  seaLevel: 12,
							  grndLevel: 12)
		let weather = Weather(id: 22, main: "Chicago", description: "Chicago", icon: "d10")
		let wind = Wind(speed: 12, deg: 21)
		let countryDetails = CountryDetails(country: "US")
		let weatherReport = WeatherReport(id: 200, name: "Testing", main: details, weather: [weather], wind: wind, sys: countryDetails, visibility: 12)
		let weatherDetails = WeatherDetails(message: "Success", list: [weatherReport])
		mockDataSource.weatherDetails = weatherDetails
		
		do {
			let result = try await repository.getWeatherDetails(parameters: [:])
			XCTAssertEqual(result, weatherDetails, "The weather details are not matching")
		} catch {
			XCTAssert(true)
		}
	}
	
	func testGetLocationFromCoordinates() async {
		let geoLocation = [GeoLocation(name: "Chicago", country: "US", state: "IL")]
		mockDataSource.geoLocation = geoLocation
		
		do {
			let result = try await repository.getLocationDetails(parameters: [:])
			XCTAssertEqual(result, geoLocation, "The location details are not matching")
		} catch {
			XCTAssert(true)
		}
	}
		
}
