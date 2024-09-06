//
//  MockURLSession.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import Foundation
@testable import WeatherApp

class MockURLSession: URLSessionProtocol {
	private(set) var request: URLRequest?
	var response: MockResponse = MockResponses.Generic.success.rawValue
	var returnInvalidHTTPURLResponse: Bool = false
	
	func data(for request: URLRequest) async throws -> (Data, URLResponse) {
		self.request = request
		guard !returnInvalidHTTPURLResponse else {
			let response = URLResponse(url: URL(string: "tesing.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
			return (Data(), response)
		}
		
		let _response = HTTPURLResponse(url: request.url!, statusCode: response.statusCode, httpVersion: nil, headerFields: nil)!
		return (response.returnData, _response)
	}
}
