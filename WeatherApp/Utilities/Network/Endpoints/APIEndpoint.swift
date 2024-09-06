	//
	//  APIEndpoint.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

import Foundation

public enum HTTPMethod: CustomStringConvertible {
	case get
	case post(body: HTTPBody)
	case put(body: HTTPBody)
	case delete
	
	public var description: String {
		switch self {
				case .get: return "GET"
				case .post: return "POST"
				case .put: return "PUT"
				case .delete: return "DELETE"
		}
	}
}

public enum HTTPScheme: String {
	case http
	case https
}

public protocol APIResource {}

public protocol APIEndpoint {
	
		/// HTTPScheme for this endpoint. ( for now it's only https. In case we need http, we need to change this)
	var scheme: HTTPScheme { get }
	
		/// The path for this endpoint
	var path: String { get }
	
		/// Query string for the url
	var query: String? { get }
	
		/// HTTP Method
	var method: HTTPMethod { get }
	
		/// Paramertes
	var parameters: [String: String] { get }
	
	func buildURLRequest(baseURLProvider: BaseURLProvider) async throws -> URLRequest
	
}

public extension APIEndpoint {
	
	var scheme: HTTPScheme { .https }
	var query: String? { nil }
	var parameters: [String: String] { [:]}
	
	internal func buildURL(baseURLProvider: BaseURLProvider) throws -> URL {
		var components = URLComponents()
		guard let url = URL(string: baseURLProvider.baseURL()),
			  let host = url.host else { throw EncodingError.invalidValue(baseURLProvider.baseURL(), EncodingError.Context(codingPath: [], debugDescription: "Invalid base url"))}
		components.scheme = scheme.rawValue
		components.host = host
		components.path = url.path + path
		
		if !parameters.isEmpty {
			let queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value).percentEncoded() }
			components.percentEncodedQueryItems = queryItems
		}
		
		guard let url = components.url else { throw EncodingError.invalidValue(baseURLProvider.baseURL(), EncodingError.Context(codingPath: [], debugDescription: "Invalid base url"))}
		return url
	}
	
	func buildURLRequest(baseURLProvider: BaseURLProvider) async throws -> URLRequest {
		let url = try buildURL(baseURLProvider: baseURLProvider)
		var request = URLRequest(url: url)
		
			// If authentication required, add the token
		request.httpMethod = method.description
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		if let data = httpBody() {
			request.httpBody = data
		}
		
			// Add if there are any headers.
		
		return request
	}
	
	private func httpBody() ->	Data? {
		switch method {
			case .post(let body), .put(let body):
				return body.data
			default:
				return nil
		}
	}
}
