//
//  BaseViewModel.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 28.05.2023.
//

import Foundation

class BaseViewModel {
    let networkService = BaseNetworkService()
    
    func handleRequestResult<T>(result: Result<T, Error>, successBlock: (T) -> Void, failureBlock: (Error) -> Void) {
        switch result {
        case .success(let response):
            successBlock(response)
        case .failure(let error):
            failureBlock(error)
        }
    }
}
