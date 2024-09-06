//
//  MockEndpoints.swift
//  WeatherApp
//
//  Created by Sreenath Reddy Bollam on 06/09/24.
//

import Foundation
@testable import WeatherApp

protocol MockedEndpoint: APIEndpoint {
	associatedtype EndpointMocks: MockResponseEnum
	func mockResponse(_: EndpointMocks) -> MockResponse
}

extension MockedEndpoint {
	func mockResponse(_ endpointMocks: EndpointMocks) -> MockResponse {
		return endpointMocks.rawValue
	}
}
