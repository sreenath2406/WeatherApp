	//
	//  Networking.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

import Foundation

public class Networking: NetworkingProtocol {
	
	private let baseURLProvider: BaseURLProvider
	private let session: URLSessionProtocol
	
	required public init(session: URLSessionProtocol = URLSession.shared, baseURLProvider: BaseURLProvider) {
		self.baseURLProvider = baseURLProvider
		self.session = session
	}
	
	func request(endpoint: any APIEndpoint) async throws -> Data {
		do {
				/// Ask the endpoint to build a URLRequest
			let request = try await endpoint.buildURLRequest(baseURLProvider: baseURLProvider)
			
				/// Make network request
			let (data, urlResponse) = try await session.data(for: request)
			
				/// Convert URLResponse to HTTPURLResponse
			guard let response = urlResponse.httpUrlResponse else { throw NetworkingError.invalidResponse }
			
				/// Check if the statusCode is 200...299
			guard response.isSuccessful else { throw NetworkingError.unkownError }
			
				/// Success
			return data
		} catch {
			throw NetworkingError.wrappedError(error)
		}
	}
	
	func request<Value>(endpoint: any APIEndpoint, returnType: Value.Type, decoder: JSONDecoder) async throws -> Value where Value : Decodable {
		let data = try await request(endpoint: endpoint)
		
		do {
			let value = try decoder.decode(returnType, from: data)
			return value
		}
		catch {
			throw NetworkingError.wrappedError(error)
		}
	}
	
	
}
