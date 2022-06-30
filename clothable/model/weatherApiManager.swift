//
//  weatherApiManager.swift
//  clothable
//
//  Created by Nikola Jeremic on 22.3.22..
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
   
    
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=74b8ff04103ad6283d5e5b1e8605ddf3&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(imeGrada: String) {
        let urlString = "\(weatherURL)&q=\(imeGrada)"
        posaljiRequest(urlString: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        posaljiRequest(urlString: urlString)
    }
    
    func posaljiRequest(urlString: String){
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let desc = decodedData.weather[0].description
            let id = decodedData.weather[0].id
            let wind = decodedData.wind.speed
            let timeZoneOffset = decodedData.timezone
//            let list = decodedData.list
//            print(list)
            let sysSunrise = decodedData.sys.sunrise + decodedData.timezone
            let sysSunset = decodedData.sys.sunset + decodedData.timezone
            
            
            
            
            
            let fullDistance = sysSunset - sysSunrise
            let currentDistance = Date().timeIntervalSince1970 - sysSunrise + timeZoneOffset
            let currentProgress = currentDistance / fullDistance
            print(currentProgress)
           // print(timeZoneOffset)
            
            print("timestamp sunrise \(sysSunrise)")
            print("timestamp sunset \(sysSunset)")
            
            
            let weather = WeatherModel(conditionIdCloud: id, temperatureNum: Double(temp), cityName: name, description: desc, windSpeed: wind, sys: Int(sysSunrise), sys2:Int(sysSunset), currentProgresInfo: Float(currentProgress), timezone: timeZoneOffset)
            
            
            
            return weather
            
          
            
        } catch {
            print(error)
            return nil
        }
    }
}


