//
//  NetworkingError.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 05/09/24.
//

import Foundation

public enum NetworkingError: LocalizedError {
	case invalidResponse
	case unkownError
	case noConnection
	case wrappedError(Error)
	case decodingFailed
	
	public var errorDescription: String? {
		switch self {
			case .invalidResponse: return "Invalid response"
			case .unkownError: return "Unknown error"
			case .noConnection: return "No connection"
			case .decodingFailed: return "Decoding failed"
			case .wrappedError(let error):
				return error.localizedDescription
		}
	}
}
