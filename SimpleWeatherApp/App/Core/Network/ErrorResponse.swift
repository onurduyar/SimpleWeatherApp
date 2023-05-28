//
//  ErrorResponse.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation

enum ErrorResponse: Error {
    
    var rawValue: String {
        switch self {
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .responseNotFound:
            return "Response not found."
        case .dataNotFound:
            return "Data not found."
        case .invalidResponse:
            return "Invalid response."
        case .fileNotFound:
            return "Local JSON file not found."
        case .apiKeyMissing:
            return "API_KEY missing."
        }
    }
    
    case invalidEndpoint
    case responseNotFound
    case dataNotFound
    case invalidResponse
    case fileNotFound
    case apiKeyMissing
}
