	//
	//  SearchLocationResource.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

internal protocol SearchLocationEndpoint: APIEndpoint {}
internal extension SearchLocationEndpoint {
	var method: HTTPMethod { .get }
}
enum SearchLocationResource: APIResource {
	case getWeather(parameters: [String: String])
	case getLocationFromCooridnates(parameters: [String: String])
	
	public var endpoint: APIEndpoint {
		switch self {
			case .getWeather(parameters: let parameters):
				return SearchLocation(parameters: parameters, body: .empty)
			case .getLocationFromCooridnates(parameters: let parameters):
				return ReverseGeoCoding(parameters: parameters, body: .empty)
		}
	}
	
	internal struct SearchLocation: SearchLocationEndpoint {
		var path: String { "/data/2.5/find" }
		var parameters: [String : String]
		var body: HTTPBody
		
		var method: HTTPMethod { .get }
	}
	
	internal struct ReverseGeoCoding: SearchLocationEndpoint {
		var path: String { "/geo/1.0/reverse" }
		var parameters: [String : String]
		var body: HTTPBody
		
		var method: HTTPMethod { .get }
	}
}
