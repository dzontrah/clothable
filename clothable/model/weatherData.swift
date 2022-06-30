//
//  weatherData.swift
//  clothable
//
//  Created by Nikola Jeremic on 22.3.22..
//

import Foundation

class WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
    let timezone: Double
    //let list: [List]

}

class WeatherDailyData: Codable {
    let list: [List]

}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Sys: Codable {
    var sunrise: Double
    var sunset: Double
}

struct Wind: Codable {
    let speed: Double
}

struct List: Codable {
    let dt: Int
    let dt_txt: String
    let weather: [Weather]
    let main: Main

    //let id: Int
    

}
