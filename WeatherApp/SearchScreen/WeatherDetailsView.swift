	//
	//  WeatherView.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 06/09/24.
	//

import SwiftUI

struct WeatherDetailsView: View {
	var weatherReport: WeatherReport?
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack(spacing: 4) {
				Text(weatherReport?.name ?? Constants.kEmptyString)
				
				if let country = weatherReport?.sys?.country {
					Text(", \(country)")
				}
				
				Spacer()
			}
			.font(.title)
			
			Text("\(String(format: "%.0f", weatherReport?.main?.temp ?? 0.0))°C")
				.font(.subheadline)
			
			/// In real time, can create an extension .
			Group {
				Text(String(format: NSLocalizedString("feels_like", comment: Constants.kEmptyString),
							String(format: "%.0f", weatherReport?.main?.feelsLike ?? 0.0)))
				Text(String(format: NSLocalizedString("humidty_value", comment: Constants.kEmptyString),
							String(format: "%.0f", weatherReport?.main?.humidity ?? 0.0)))
				Text(String(format: NSLocalizedString("visibility_value", comment: Constants.kEmptyString),
							String(format: "%d", (weatherReport?.visibility ?? 0)/1000)))
			}
			.font(.caption)
		}
		.padding(8)
		.background(backgroundView)
		.frame(maxWidth: .infinity)
	}
	
	private var backgroundView: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 8)
				.fill(.white)
				.overlay {
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.gray.opacity(0.5), lineWidth: 1)
				}
		}
		.shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
	}
}
