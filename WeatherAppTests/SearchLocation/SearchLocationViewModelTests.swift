//
//  SearchLocationViewModelTests.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//
import XCTest
import Combine
@testable import WeatherApp

class SearchLocationViewModelTests: XCTestCase {
	var mockRepository: MockSearchLocationRepository!
	var viewModel: SearchLocationViewModel!
	var cancellables: Set<AnyCancellable>!
	
	override func setUp() {
		super.setUp()
		mockRepository = MockSearchLocationRepository()
		viewModel = SearchLocationViewModel(searchLocationRepository: mockRepository)
		cancellables = Set<AnyCancellable>()
	}
	
	override func tearDown() {
		viewModel = nil
		mockRepository = nil
		cancellables = nil
		super.tearDown()
	}
	
	func testInitialState() {
		XCTAssertEqual(viewModel.searchLocation, UserDefaults.standard.string(forKey: Constants.kPreviousLocation) ?? Constants.kEmptyString)
		XCTAssertNil(viewModel.weatherDetails)
		XCTAssertEqual(viewModel.loadState, .empty)
		XCTAssertEqual(viewModel.errorMessage, Constants.kEmptyString)
	}
}
