//
//  CitiesViewModel.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 28.05.2023.
//

import UIKit

final class CitiesViewModel:BaseViewModel {
    // Properties
    private let localJSONNetworkService = LocalJSONNetworkService()
    private var isLoading = false {
        didSet {
            if isLoading {
                delegate?.showActivityIndicator()
            } else {
                delegate?.hideActivityIndicator()
            }
        }
    }
    
    private var cities: [City]? {
        didSet {
            delegate?.citiesDataDidChange(self)
        }
    }
    private var mainCities: [City]? {
        didSet {
            delegate?.citiesDataDidChange(self)
        }
    }
    
    var citiesCount: Int {
        return cities?.count ?? 0
    }
    
    func city(at index: Int) -> City? {
        return cities?[index]
    }
    
    weak var delegate: CitiesViewModelDelegate?
    
    // methods
    func viewDidLoad() {
        fetchCities()
    }
    
    func fetchCities() {
        self.isLoading = true
        localJSONNetworkService.request(LocalRequest()) { [weak self] result in
            self?.handleRequestResult(result: result, successBlock: { response in
                self?.cities = self?.moveTRCitiesToBeginning(response)
                self?.mainCities = self?.cities
                self?.isLoading = false
            }, failureBlock: { error in
                fatalError(error.localizedDescription)
            })
        }
    }
    
    func fetchWeather(for city: City) {
        guard let id = city.id else { return }
        networkService.request(WeatherRequest(id: String(id))) { [weak self] result in
            self?.handleRequestResult(result: result, successBlock: { response in
                self?.delegate?.weatherDataDidChange(self ?? CitiesViewModel(), weather: response)
            }, failureBlock: { error in
                fatalError(error.localizedDescription)
            })
        }
    }
    
    func updateSearchResults(for text: String) {
        if text.count > 1 {
            let filteredCities = mainCities?.filter { $0.name?.lowercased().contains(text.lowercased()) ?? false }
            cities = filteredCities
        } else {
            cities = mainCities
        }
    }
    
    func didDismissSearchController() {
        cities = mainCities
    }
    
    private func moveTRCitiesToBeginning(_ array: [City]) -> [City] {
        let trCities = array.filter { $0.country == "TR" }
        let nonTrCities = array.filter { $0.country != "TR" }
        let combinedCities = trCities + nonTrCities
        return combinedCities
    }
    
}

protocol CitiesViewModelDelegate: AnyObject {
    func citiesDataDidChange(_ viewModel: CitiesViewModel)
    func weatherDataDidChange(_ viewModel: CitiesViewModel, weather: WeatherElement)
    func weatherDataFetchDidFail(_ viewModel: CitiesViewModel, withError error: Error)
    func showActivityIndicator()
    func hideActivityIndicator()
}
