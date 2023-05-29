//
//  CitiesVC.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 24.05.2023.
//

import UIKit

final class CitiesVC: UIViewController {
    private let viewModel = CitiesViewModel()
    private let citiesView = CitiesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = citiesView
        
        citiesView.setTableViewDelegate(delegate: self, andDataSource: self)
        citiesView.setSearchControllerDelegate(delegate: self, resultUpdater: self)
        
        navigationItem.searchController = citiesView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        viewModel.delegate = self
        
    
        
        citiesView.activityIndicator.startAnimating()
             DispatchQueue.main.async {
                 self.viewModel.fetchCities {
                     self.citiesView.refresh()
                     self.citiesView.activityIndicator.stopAnimating()
                 } onfailed: {
                     
                 }
             }

    }
}


extension CitiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = viewModel.city(at: indexPath.row) else { return }
        viewModel.fetchWeather(for: city)
    }
}

extension CitiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citiesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        guard let city = viewModel.city(at: indexPath.row) else { return cell }
        cell.textLabel?.text = city.name
        return cell
    }
}

extension CitiesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            viewModel.updateSearchResults(for: searchText)
        }
    }
}

extension CitiesVC: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.didDismissSearchController()
    }
}

extension CitiesVC: CitiesViewModelDelegate {
    func showActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.citiesView.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.citiesView.activityIndicator.stopAnimating()
        }
    }
    
    func citiesDataDidChange(_ viewModel: CitiesViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.citiesView.refresh()
        }
    }
    
    func weatherDataDidChange(_ viewModel: CitiesViewModel, weather: WeatherElement) {
        DispatchQueue.main.async { [weak self] in
            guard let tabBarController = self?.tabBarController else {return}
            guard let _ = tabBarController.viewControllers?[0] as? WeatherVC else {return}
            WeatherViewModel.shared.selectedCity = weather
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
            UIView.transition(with: (tabBarController.view)!, duration: 0.5, options: transitionOptions, animations: {
                self?.tabBarController?.selectedIndex = 0
            }, completion: nil)
            
        }
    }
    
    func weatherDataFetchDidFail(_ viewModel: CitiesViewModel, withError error: Error) {
        DispatchQueue.main.async {
            fatalError(error.localizedDescription)
        }
    }
}
