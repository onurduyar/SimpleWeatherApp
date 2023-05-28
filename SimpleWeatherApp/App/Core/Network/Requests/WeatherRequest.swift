//
//  ExampleRequest.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation

struct WeatherRequest: APIRequest {
    let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    
    let id: String
    let appID: String
    
    typealias Response = WeatherElement
    
    var path: String {
        Endpoint.data.rawValue.appending(Endpoint.APIVersion.rawValue).appending(Endpoint.weather.rawValue)
    }
    var method: HTTPMethod {
        .get
    }
    var queryItems: [String : String] {
        [
            "appid": appID,
            "id": id,
            "units": Endpoint.metric.rawValue
        ]
    }
    init(id: String) {
        self.id = id
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            fatalError(ErrorResponse.apiKeyMissing.rawValue)
        }
        self.appID = apiKey
    }
    func decode(_ data: Data) throws -> WeatherElement {
        try JSONDecoder().decode(Response.self, from: data)
    }
}

