	//
	//  WeatherDetails.swift
	//  WeatherApp
	//
	//  Created by Sreenath Reddy Bollam on 05/09/24.
	//

struct WeatherDetails: Codable, Hashable {
	let message: String?
	let list: [WeatherReport]?
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.message = try container.decodeIfPresent(String.self, forKey: .message)
		self.list = try container.decodeIfPresent([WeatherReport].self, forKey: .list)
	}
	
	init (message: String, list: [WeatherReport]) {
		self.message = message
		self.list = list
	}
}
struct WeatherReport: Codable, Hashable {
	let id: Int?
	let name: String?
	let main: Details?
	let weather: [Weather]?
	let wind: Wind?
	let sys: CountryDetails?
	let visibility: Float?
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decodeIfPresent(Int.self, forKey: .id)
		self.name = try container.decodeIfPresent(String.self, forKey: .name)
		self.main = try container.decodeIfPresent(Details.self, forKey: .main)
		self.weather = try container.decodeIfPresent([Weather].self, forKey: .weather)
		self.wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
		self.sys = try container.decodeIfPresent(CountryDetails.self, forKey: .sys)
		self.visibility = try container.decodeIfPresent(Float.self, forKey: .visibility)
	}
	
	init (id: Int, name: String, main: Details, weather: [Weather], wind: Wind, sys: CountryDetails, visibility: Float) {
		self.id = id
		self.name = name
		self.main = main
		self.weather = weather
		self.wind = wind
		self.sys = sys
		self.visibility = visibility
	}
}

struct Weather: Codable, Hashable {
	let id: Int?
	let main: String?
	let description: String?
	let icon: String?
}

struct CountryDetails: Codable, Hashable {
	let country: String?
}

struct Wind: Codable, Hashable {
	let speed: Float?
	let deg: Int?
}

struct Details: Codable, Hashable {
	let temp: Float?
	let feelsLike: Float?
	let tempMin: Float?
	let tempMax: Float?
	let pressure: Int?
	let humidity: Int?
	let seaLevel: Int?
	let grndLevel: Int?
}
