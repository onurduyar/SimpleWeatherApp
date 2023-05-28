//
//  SwiftUIView.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 25.05.2023.
//

import SwiftUI

struct WeatherView: View {
    var selectedWeather: WeatherElement?
    var a: Int?
    var body: some View {
        ScrollView {
            
        
        VStack {
            if let selectedWeather,
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
               let description = selectedWeather.weather?.first?.description {
                
                Group {
                    Text(cityName)
                        .font(.largeTitle).fontWeight(.bold).padding(.top, 20)
                    Text(String(format: "Current: %.1f C", currentTemp))
                        .font(.body).padding(2)
                    Text(String(format: "Feels Like: %.1f C",feelsLike ))
                        .font(.body).padding(2)
                    HStack{
                        Text(String(format: "H: %.1f C",tempMax))
                            .font(.body).padding(2)
                        Text(String(format: "L: %.1f C",tempMin ))
                            .font(.body).padding(2)
                    }
                }
                
                Divider().frame(height: 3).overlay(.gray).padding(.top, 4)
                Spacer()
                
                Group {
                    ShortCardView(data:humidity ,text: "Humidity",percentSign: "%")
                        .padding(7)
                    LongCardView(firstData: wind.speed,secondData: Double(wind.deg!) ,text: "Wind", firstVText: "Speed", secondVText: "Gust",unit: "km/h")
                        .padding(7)
                    ShortCardView(data: pressure,text: "Sea Level",percentSign: "")
                        .padding(7)
                    LongCardView(firstData: coordinate.lat, secondData: coordinate.lon,text: "Coordinate", firstVText: "Latitude", secondVText: "Longtitude",unit: "")
                        .padding(7)
                    
                }
                Group {
                    Spacer()
                    Divider().frame(height: 3).overlay(.gray)
                    Text("\(description)")
                        .font(.body).padding(2)
                    Divider().frame(height: 3).overlay(.gray)
                    
                }
            }
            
            
        }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
