//
//  WeatherViewModel.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 26.05.2023.
//

import Foundation

final class WeatherViewModel:BaseViewModel {
    static let shared = WeatherViewModel()
    weak var delegate: WeatherViewModelDelegate?
    
    var selectedCity: WeatherElement? {
        didSet {
            delegate?.weatherDataDidChange(self)
        }
    }
    
    private override init() {}
    
    func fetchWeather(by id: String) {
        networkService.request(WeatherRequest(id: id)) { result in
            self.handleRequestResult(result: result) { response in
                self.selectedCity = response
            } failureBlock: { error in
                self.delegate?.weatherDataFetchDidFail(self, withError: error)
            }

        }
    }
}

protocol WeatherViewModelDelegate: AnyObject {
    func weatherDataDidChange(_ viewModel: WeatherViewModel)
    func weatherDataFetchDidFail(_ viewModel: WeatherViewModel, withError error: Error)
}
