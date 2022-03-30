//
//  WeatherModel.swift
//  Clima
//
//  Created by Sachin Pandey on 24/03/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let id: Int
    let name: String
    let temp:  Double

    
    var tempString : String {
        let str=String(format: "%.1f", temp)
        return str
    }
    
    var conditionName: String {
    switch id {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
    }}

    
}
