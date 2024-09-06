	//
	//  ContentView.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

import SwiftUI
import CoreLocation

struct SearchLocationView: View {
	@ObservedObject var searchLocationViewModel: SearchLocationViewModel
	@FocusState private var isSearchTFFocused: Bool
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				contentView
				Spacer()
			}
			.searchable(text: $searchLocationViewModel.searchLocation, prompt: LocalizedStringKey("search_location_placeholder"))
			.onChange(of: searchLocationViewModel.searchLocation, { oldValue, newValue in
				Task {
					try await searchLocationViewModel.getWeather()
				}
			})
			.padding()
			.onAppear {
				searchLocationViewModel.requestLocationPermission()
			}
		}
	}
	
	private func getWeatherDetails() {
		Task {
			try await searchLocationViewModel.getWeather()
		}
	}

	private var contentView: some View {
		VStack(alignment: .center) {
			switch searchLocationViewModel.loadState {
				case .loading:
					/// For now used progressView, but can create a cards with shimmering effect.
					ProgressView()
				case .empty:
					Text(LocalizedStringKey("empty_search_text"))
				case .error:
					Text(searchLocationViewModel.errorMessage)
						.foregroundStyle(.red)
				case .success:
					if let weatherDetails = searchLocationViewModel.weatherDetails?.list {
						List(weatherDetails, id: \.id) { weather in
							WeatherDetailsView(weatherReport: weather)
								.listRowSeparator(.hidden)
								.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 12, trailing: 0))
						}
						.listBackgroundColor(.white)
						.listStyle(.grouped)
						.background(Color.white)
					} else {
						Text(LocalizedStringKey("no_data_found"))
					}
			}
		}
		.background(Color.white)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

#Preview {
	SearchLocationView(searchLocationViewModel: SearchLocationViewModel())
}
