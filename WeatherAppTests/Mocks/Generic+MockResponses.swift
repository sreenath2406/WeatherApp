	//
	//  Generic+MockResponses.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 06/09/24.
	//

import Foundation

extension MockResponses {
	
	enum Generic: RawRepresentable {
		case success
		case apiErrorInvalidResponse
		case custom(Int, Data)
		
		typealias RawValue = MockResponse
		
		init?(rawValue: MockResponse) {
			self = .custom(rawValue.statusCode, rawValue.returnData)
		}
		
		var rawValue: RawValue {
			switch self {
				case .success: return SuccessfulResponse()
				case .apiErrorInvalidResponse: return APIErrorInvalidResponse()
				case .custom(let statusCode, let data): return CustomResponse(statusCode: statusCode, returnData: data)
			}
		}
		
		private struct SuccessfulResponse: MockResponse {
			var statusCode: Int = 200
			var returnData: Data = Data()
		}
		
		private struct APIErrorInvalidResponse: MockResponse {
			var statusCode: Int = 400
			var returnData: Data = Data()
		}
		
		private struct CustomResponse: MockResponse {
			var statusCode: Int
			var returnData: Data
		}
	}
}
