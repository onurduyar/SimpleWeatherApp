//
//  WeatherViewUIKit.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 26.05.2023.
//

import UIKit

final class WeatherViewUIKit: UIView {
    
    var selectedWeather: WeatherElement? {
        didSet {
            reloadData()
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    
    private let titleLabel: UILabel = createLabel(size: 30)
    private let currentTempLabel: UILabel = createLabel(size: 20)
    private let feelsLikeLabel: UILabel = createLabel(size: 20)
    private let tempMaxLabel: UILabel = createLabel(size: 20)
    private let tempMinLabel: UILabel = createLabel(size: 20)
    private let humidityLabel: UILabel = createLabel(size: 20)
    private let pressureLabel: UILabel = createLabel(size: 20)
    private let windSpeedLabel: UILabel = createLabel(size: 20)
    private let gustLabel: UILabel = createLabel(size: 20)
    private let latitudeLabel: UILabel = createLabel(size: 20)
    private let longitudeLabel: UILabel = createLabel(size: 20)
    private let descriptionLabel: UILabel = createLabel(size: 20)
    
    private let humidityKeyLabel: UILabel = createLabel(size: 20)
    private let windKeyLabel: UILabel = createLabel(size: 20)
    private let seaLevelKeyLabel: UILabel = createLabel(size: 20)
    private let coordinatesKeyLabel: UILabel = createLabel(size: 20)
    
    private let humidityCard: UIView = createCardView()
    private let windCard: UIView = createCardView()
    private let pressureCard: UIView = createCardView()
    private let coordinateCard: UIView = createCardView()
    private let line: UIView = UIView()
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        // Container
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pinToEdges(of: self)
        
        // Temp StackView
        let tempStackView = WeatherViewUIKit.createHorizontalStackView(with: [tempMaxLabel, tempMinLabel])
        titleLabel.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        // Weather StackView
        let weatherStackView = WeatherViewUIKit.createVerticalStackView(with: [titleLabel, currentTempLabel, feelsLikeLabel, tempStackView])
        containerView.addSubview(weatherStackView)
        weatherStackView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, bottom: nil, topPadding: 60, leadingPadding: 16, trailingPadding: -16)
        
        // Humidity StackView
        let humidityLabelStack = WeatherViewUIKit.createHorizontalStackView(with: [humidityKeyLabel, UIView(), humidityLabel])
        humidityCard.addSubview(humidityLabelStack)
        humidityLabelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            humidityLabelStack.centerYAnchor.constraint(equalTo: humidityCard.centerYAnchor)
        ])
        humidityLabelStack.anchor(top: nil, leading: humidityCard.leadingAnchor, trailing: humidityCard.trailingAnchor, bottom: nil, leadingPadding: 16, trailingPadding: -16)
        
        // Wind StackView
        let windVStack = WeatherViewUIKit.createVerticalStackView(with: [windSpeedLabel, gustLabel])
        let windLabelStack = WeatherViewUIKit.createHorizontalStackView(with: [windKeyLabel, UIView(), windVStack])
        windCard.addSubview(windLabelStack)
        windLabelStack.centerInSuperview()
        windLabelStack.anchor(top: nil, leading: windCard.leadingAnchor, trailing: windCard.trailingAnchor, bottom: nil, leadingPadding: 16, trailingPadding: -16)
        
        // Sea Level StackView
        let seaLevelStack = WeatherViewUIKit.createHorizontalStackView(with: [seaLevelKeyLabel, UIView(), pressureLabel])
        pressureCard.addSubview(seaLevelStack)
        seaLevelStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seaLevelStack.centerYAnchor.constraint(equalTo: pressureCard.centerYAnchor)
        ])
        seaLevelStack.anchor(top: nil, leading: pressureCard.leadingAnchor, trailing: pressureCard.trailingAnchor, bottom: nil, leadingPadding: 16, trailingPadding: -16)
        
        
        // Coordinates StackView
        let coordinatesVStack = WeatherViewUIKit.createVerticalStackView(with: [latitudeLabel, longitudeLabel])
        let coordinatesStack = WeatherViewUIKit.createHorizontalStackView(with: [coordinatesKeyLabel, UIView(), coordinatesVStack])
        coordinateCard.addSubview(coordinatesStack)
        coordinatesStack.centerInSuperview()
        coordinatesStack.anchor(top: nil, leading: coordinateCard.leadingAnchor, trailing: coordinateCard.trailingAnchor, bottom: nil, leadingPadding: 16, trailingPadding: -16)
        
        // Cards StackView
        let cardStackView = WeatherViewUIKit.createVerticalStackView(with: [humidityCard, windCard, pressureCard, coordinateCard, descriptionLabel])
        cardStackView.spacing = 35
        cardStackView.backgroundColor = .white
        containerView.addSubview(cardStackView)
        cardStackView.anchor(top: weatherStackView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,bottom: nil, topPadding: 40, leadingPadding: 16, trailingPadding: -16)
        
        NSLayoutConstraint.activate([
            humidityCard.heightAnchor.constraint(equalToConstant: 50),
            windCard.heightAnchor.constraint(equalToConstant: 100),
            pressureCard.heightAnchor.constraint(equalToConstant: 50),
            coordinateCard.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func reloadData() {
        guard let selectedWeather = selectedWeather,
              let cityName = selectedWeather.name,
              let main = selectedWeather.main,
              let currentTemp = main.temp,
              let feelsLike = main.feelsLike,
              let tempMax = main.tempMax,
              let tempMin = main.tempMin,
              let humidity = main.humidity,
              let pressure = main.pressure,
              let wind = selectedWeather.wind,
              let coordinate = selectedWeather.coord,
              let description = selectedWeather.weather?.first?.description else {
            return
        }
        
        // Key labels
        humidityKeyLabel.text = "Humidity"
        windKeyLabel.text = "Wind"
        seaLevelKeyLabel.text = "Sea Level"
        coordinatesKeyLabel.text = "Coordinates"
        
        // Attributes
        titleLabel.text = cityName
        currentTempLabel.text = String(format: "Current: %.1f C", currentTemp)
        feelsLikeLabel.text = String(format: "Feels Like: %.1f C", feelsLike)
        tempMaxLabel.text = String(format: "H: %.1f C", tempMax)
        tempMinLabel.text = String(format: "L: %.1f C", tempMin)
        humidityLabel.text = "\(humidity)"
        windSpeedLabel.text = String(format: "Speed: %.1fkm/h", wind.speed ?? 0.0)
        gustLabel.text = "Gust: \(wind.deg ?? 0)km/h"
        pressureLabel.text = "\(pressure)"
        latitudeLabel.text = String(format: "Latitude: %.1f", coordinate.lat ?? 0.0)
        longitudeLabel.text = String(format: "Longitude: %.1f", coordinate.lon ?? 0.0)
        descriptionLabel.text = description
    }
    
    // Helper methods
    
    private static func createLabel(size: CGFloat?) -> UILabel {
        let label = UILabel()
        guard let size else {return label}
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }
    
    private static func createCardView() -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        card.layer.borderWidth = 2
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.cornerRadius = 14
        return card
    }
    
    private static func createHorizontalStackView(with arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }
    
    private static func createVerticalStackView(with arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
}

