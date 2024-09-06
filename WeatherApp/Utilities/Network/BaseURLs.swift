	//
	//  BaseURLs.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

import Foundation

class BaseURLs {
	/// Add few more params if required.
	internal let hostBaseURL: String = "https://api.openweathermap.org"
	
	internal let apiKeyValue: String = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String ?? Constants.kEmptyString
	static let shared = BaseURLs()
	
	private init() { }
}

extension BaseURLs: BaseURLProvider {
	func baseURL() -> String {
		return hostBaseURL
	}
	
	func apiKey() -> String {
		return apiKeyValue
	}
}
