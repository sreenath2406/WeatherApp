//
//  MockResponse.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import Foundation
@testable import WeatherApp
import XCTest

enum MockResponses {}

protocol MockResponseEnum {
	var rawValue: MockResponse { get }
}

protocol MockResponse {
	var statusCode: Int { get }
	var returnData: Data { get }
}

struct MockTestCase<T: MockedEndpoint> {
	var endpoint: APIEndpoint
	var url: URL
	var response: MockResponse
	
	init(endpoint: T, mock: T.EndpointMocks, baseURLProvider: BaseURLProvider) {
		self.endpoint = endpoint as APIEndpoint
		let url = try? endpoint.buildURL(baseURLProvider: baseURLProvider)
		XCTAssertNotNil(url)
		self.url = url!
		self.response = endpoint.mockResponse(mock)
	}
}
