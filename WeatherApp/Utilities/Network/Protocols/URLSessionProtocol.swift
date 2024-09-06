//
//  URLSessionProtocol.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//

import Foundation

public protocol URLSessionProtocol {
	func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
