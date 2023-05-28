//
//  LocalRequest.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation

struct LocalRequest :DataRequest{
    var baseURL: String {
        ""
    }
    var method: HTTPMethod {
        .get
    }
    typealias Response = [City]
    
    var url: String {
        guard let fileURL = Bundle.main.url(forResource: "city.list", withExtension: "json") else {
            fatalError(ErrorResponse.fileNotFound.rawValue)
        }
        return fileURL.absoluteString
    }
    
    func decode(_ data: Data) throws -> [Response] {
        try JSONDecoder().decode([Response].self, from: data)
        
    }
}
