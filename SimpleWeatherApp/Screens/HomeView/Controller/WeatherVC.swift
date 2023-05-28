//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 23.05.2023.
//

import UIKit
import SwiftUI

final class WeatherVC: UIViewController {
    let swiftUIHostingController = UIHostingController(rootView: WeatherView(selectedWeather: nil))
    let activityIndicator = UIActivityIndicatorView()
    var weatherViewModel = WeatherViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        weatherViewModel.delegate = self
        
        fetchWeather(by: "745042") // default İstanbul
    }
    
    func setupSwiftUI() {
        addChild(swiftUIHostingController)
        view.addSubview(swiftUIHostingController.view)
        swiftUIHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        swiftUIHostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        swiftUIHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        swiftUIHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        swiftUIHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        swiftUIHostingController.didMove(toParent: self)
    }
    
    func fetchWeather(by id: String) {
        activityIndicator.startAnimating()
        weatherViewModel.fetchWeather(by: id)
    }
}
// MARK: - WeatherViewModelDelegate
extension WeatherVC: WeatherViewModelDelegate {
    func weatherDataDidChange(_ viewModel: WeatherViewModel) {
        DispatchQueue.main.async {
            self.setupSwiftUI()
            self.swiftUIHostingController.rootView = WeatherView(selectedWeather: viewModel.selectedCity)
            self.activityIndicator.stopAnimating()
        }
    }
    func weatherDataFetchDidFail(_ viewModel: WeatherViewModel, withError error: Error) {
        DispatchQueue.main.async {
            fatalError(error.localizedDescription)
        }
    }
}
