//
//  WeatherModel.swift
//  clothable
//
//  Created by Nikola Jeremic on 22.3.22..
//

import Foundation
import SwiftUI

struct WeatherModel {
    
    let conditionIdCloud: Int
    let temperatureNum: Double
    var cityName: String
    var description: String
    let windSpeed: Double
    let sys: Int
    let sys2: Int
    let currentProgresInfo: Float
    let timezone: Double
    
       
    var temperaturaString: String {
        return String(format: "%.0f", temperatureNum)
    }
    var speedString: String {
        return String(format: "%.0f", windSpeed)
    }
    
    var sunriseInfoString: String {
        return String(sys)
    }
    var sunsetInfoString: String {
        return String(sys2)
    }
    
    var progressInfo: Float {
        return Float(currentProgresInfo)
    }
    
    var converSunrise: Double{
        return Double(sys / 1000)
    }
    var converSunset: Double{
        return Double(sys2 / 1000)
    }
   
    
    var conditionName: String {
        switch temperatureNum {
        case -40 ... -20:
            return "kapa.muska1"
        case -20 ... -10:
            return "kapa.muska1"
        case -10 ... -1:
            return "kapa.muska1"
        case -1...1:
            return "kapa.muska1"
        case 0...13:
            return "kapa.muska1"
        case 13...20:
            return "kacketmuski1"
        case 20...24:
            return "kacket.muski"
        case 24...30:
            return "lepeza"
        case 30...41:
            return "lobanja"
        default:
            return "kisobran"
        }
    }
    var conditionName2: String {
        switch temperatureNum {
        case -40 ... -20:
            return "jaknamuska1"
        case -20 ... -10:
            return "jaknamuska1"
        case -10 ... -1:
            return "kaput.muski"
        case -1...1:
            return "jaknamuska2"
        case 0...13:
            return "jaknamuska1"
        case 13...20:
            return "jaknamuska2"
        case 20...22:
            return "dzemper.muski"
        case 22...30:
            return "majca.muska"
        case 30...42:
            return "lobanja"
        default:
            return "kisobran"
    }
    }
    var conditionName3: String {
        switch temperatureNum {
        case -40 ... -20:
            return "pantalone.muske"
        case -20 ... -10:
            return "pantalone.muske"
        case -10 ... -1:
            return "pantalone.muske"
        case -1...1:
            return "pantalone.muske"
        case 0...22:
            return "pantalone.muske"
        case 22...25:
            return "bermude.muske1"
        case 25...30:
            return "sorc.muski"
        case 30...42:
            return "lobanja"
        default:
            return "kisobran"
    }
    }
    var conditionName4: String {
        switch temperatureNum {
        case -40 ... -20:
            return "cizme.muske"
        case -20 ... -10:
            return "cizme.muske"
        case -10 ... -1:
            return "cizme.muske"
        case -1...1:
            return "cizme.muske"
        case 0...13:
            return "cizme.muske"
        case 13...20:
            return "patike"
        case 20...25:
            return "patike"
        case 25...30:
            return "papuce.unisex"
        case 30...42:
            return "lobanja"
            
        default:
            return "kisobran"
    }
    }
    var conditionNameCloud: String {
        switch conditionIdCloud {
        case 200...232:
            return "storm"
        case 300...321:
            return "light.rain"
        case 500...531:
            return "heavy.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sun"
        case 801...804:
            return "storm"
        default:
            return "cloud.blue"
        }
    }
    
}
