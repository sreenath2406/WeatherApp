	//
	//  SearchLocationViewModel.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

import Foundation
import CoreLocation
import SwiftUI
import Combine

class SearchLocationViewModel: NSObject, ObservableObject {
	@Published var searchLocation: String = Constants.kEmptyString
	var searchLocationRepository: SearchLocationRepositoryProtocol
	@Published var weatherDetails: WeatherDetails?
	@Published var errorMessage: String = Constants.kEmptyString
	private let locationManager = CLLocationManager()
	private var cancellables = Set<AnyCancellable>() // Store your cancellables here
	
	enum SearchState {
		case loading
		case success
		case empty
		case error
	}
	
	var loadState: SearchState = .empty
	
	init(searchLocationRepository: SearchLocationRepositoryProtocol = SearchLocationRepository(baseURLProvder: BaseURLs.shared)) {
		self.searchLocationRepository = searchLocationRepository
		super.init()
		searchLocation = UserDefaults.standard.string(forKey: Constants.kPreviousLocation) ?? Constants.kEmptyString
		if !searchLocation.isEmpty {
			Task {
				try await getWeather()
			}
		} else {
			locationManager.delegate = self
		}
	}
	
	
		/// Fetch weather for the given location
	@MainActor
	func getWeather() async throws {
		if searchLocation.count < 3 {
			weatherDetails = nil
			loadState = .empty
			return
		}
		Future<WeatherDetails, Error> { promise in
			Task {
				do {
					let params = ["q": self.searchLocation,
								  "appid": BaseURLs.shared.apiKeyValue,
								  "units": "metric"]
					self.loadState = .loading
					let details = try await self.searchLocationRepository.getWeatherDetails(parameters: params)
					promise(.success(details))
				} catch {
					promise(.failure(error))
				}
			}
		}
		.receive(on: DispatchQueue.main)
		.sink(receiveCompletion: { completion in
			switch completion {
				case .finished:
					break
				case .failure(let failure):
					self.loadState = .error
					self.errorMessage = failure.localizedDescription
			}
			
		}, receiveValue: { weatherDetails in
			self.weatherDetails = weatherDetails
			if self.weatherDetails?.list?.isEmpty ?? true {
				self.loadState = .empty
			} else {
				self.loadState = .success
				UserDefaults.standard.set(self.searchLocation, forKey: Constants.kPreviousLocation)
			}
		})
		.store(in: &cancellables)
	}
}

extension SearchLocationViewModel: CLLocationManagerDelegate {
	
	func requestLocationPermission() {
		DispatchQueue.main.async {
			self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
			self.locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			locationManager.startUpdatingLocation()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			locationManager.stopUpdatingLocation()
			Task {
				try await self.getLocationDetailsFromCoordinates(location: location)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
			// Handle it based on the requirement.
		print("Location failed with error: \(error.localizedDescription)")
	}
}

extension SearchLocationViewModel {
	@MainActor
	func getLocationDetailsFromCoordinates(location: CLLocation) async throws{
		loadState = .loading
			/// Given the time, can move this to constants
		let params = ["lat": String(Double(location.coordinate.latitude)),
					  "lon":  String(Double(location.coordinate.longitude)),
					  "appid": BaseURLs.shared.apiKeyValue,
					  "units": "metric"]
		do {
			let locationDetails = try await searchLocationRepository.getLocationDetails(parameters: params)
			if locationDetails.count > 0 {
				self.searchLocation = locationDetails[0].name
			}
			self.loadState = .success
		} catch {
			loadState = .error
			errorMessage = error.localizedDescription
		}
	}
}
