//
//  APIRequest.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation

protocol APIRequest: DataRequest {
    associatedtype Response
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

extension APIRequest {
    var baseURL: String {
        "https://api.openweathermap.org"
    }
    
    var url: String {
        "\(path)"
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
}

