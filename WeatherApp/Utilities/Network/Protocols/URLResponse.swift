//
//  URLResponse.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//
import Foundation

extension URLResponse {
	var httpUrlResponse: HTTPURLResponse? {
		return self as? HTTPURLResponse
	}
}

extension HTTPURLResponse {
	/// Return 'true' if statusCode is in range 200..299
	/// Otherwise 'false'.
	var isSuccessful: Bool {
		return 200 ... 299 ~= statusCode
	}
}
