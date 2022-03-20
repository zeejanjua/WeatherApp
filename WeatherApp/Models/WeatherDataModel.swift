//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import Foundation

struct WeatherDataModel: Codable {
    let timezone: String
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPint: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let windSpeed: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case dewPint = "dew_point"
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case weather
    }
    
}

struct Weather: Codable {
    let id: Int
    let descriptionWeather: String
    let icon: String
    let main: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case descriptionWeather = "description"
        case icon
        case main
    }
}

struct Daily: Codable {
    
    let dt: Int
    let temp: Temp
    let humidity: Int
    let weather: [Weather]
    let rain: Double?
    
}

struct Temp: Codable {
    let min: Double
    let max: Double
    let night: Double
}

