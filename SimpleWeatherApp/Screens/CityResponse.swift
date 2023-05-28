//
//  LocalJSONResponse.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation


struct City: Codable {
    let id: Int?
    let name, state, country: String?
    let coord: Coordinate?
}

struct Coordinate: Codable {
    let lon, lat: Double?
}
