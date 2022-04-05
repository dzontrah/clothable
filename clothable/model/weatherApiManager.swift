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
            
            let weather = WeatherModel(temperatureNum: temp)
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}


