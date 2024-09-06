	//
	//  HTTPBody.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//
import Foundation

public struct HTTPBody: Codable {
	var data: Data
	static let empty = HTTPBody(data: Data())
	
	private init(data: Data) {
		self.data = data
	}
	
	public init(_ encodable: Encodable, encoder: JSONEncoder = .init()) throws {
		self.data = try encoder.encode(encodable)
	}
}
