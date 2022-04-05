//
//  WeatherModel.swift
//  clothable
//
//  Created by Nikola Jeremic on 22.3.22..
//

import Foundation

struct WeatherModel {

    let temperatureNum: Double
    
    var temperaturaString: String {
        return String(format: "%.0f", temperatureNum)
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
        default:
            return "kisobran"
    }
    }
}
