//
//  LocalJSONService.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import Foundation

struct LocalJSONNetworkService: NetworkService {
    func request<Request: DataRequest>(_ request: Request, compilation: @escaping (Result<Request.Response, Error>) -> Void) {
        do {
            let data = try Data(contentsOf: URL(string: request.url)!)
            let decodedResponse = try request.decode(data)
            compilation(.success(decodedResponse))
        } catch {
            compilation(.failure(error))
        }
    }
}
