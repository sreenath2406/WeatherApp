//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
			SearchLocationView(searchLocationViewModel: SearchLocationViewModel())
        }
    }
}
