	//
	//  Untitled.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//
import Foundation

extension URLQueryItem {
	public func percentEncoded() -> URLQueryItem {
		var newQueryItem = self
		newQueryItem.value = value?
			.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
			.replacingOccurrences(of: "+", with: "%2B")
		
		return newQueryItem
	}
}
