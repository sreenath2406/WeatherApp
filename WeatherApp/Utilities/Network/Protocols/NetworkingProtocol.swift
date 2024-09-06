//
//  NetworkingProtocol.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//

import Foundation

protocol NetworkingProtocol {
	func request(endpoint: APIEndpoint) async throws -> Data
	func request<Value: Decodable>(endpoint:APIEndpoint, returnType: Value.Type, decoder: JSONDecoder) async throws -> Value
}
