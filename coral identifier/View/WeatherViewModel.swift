//
//  WeatherViewModel.swift
//  coral indentifier
//
//  Created by PinHsuan Tsai on 2024/10/8.
//

import Foundation
import SwiftUI
import CoreLocation

/// A SwiftUI view that displays current weather information.
struct WeatherView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    
    var body: some View {
        HStack {
            if let weatherData = weatherData {
                Text("\(Int(weatherData.temperature))°C")
                    .font(Font.custom("RopaSans-Italic", fixedSize: 40))
                    .foregroundColor(.white)
                    .padding()
                
                HStack(){
                    Image("Location")
                        .frame(width: 20, height: 20)
                    Text("\(weatherData.locationName)")
                        .font(Font.custom("RopaSans-Italic", fixedSize: 30))
                        .foregroundColor(.white)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.location) { oldValue, newValue in
            if let location = newValue {
                Task {
                    await fetchWeatherData(for: location)
                }
            }
        }
    }
    /// Fetches weather data for a given location.
    /// - Parameter location: The location for which to fetch weather data.
    /// Using the OpenWeatherMap API to fetch the data
    @MainActor
    private func fetchWeatherData(for location: CLLocation) async {
        do {
            let apiKey = try APIKeyManager.shared.getAPIKey()
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(apiKey)"
            
            guard let url = URL(string: urlString) else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            
            weatherData = WeatherData(
                locationName: weatherResponse.name,
                temperature: weatherResponse.main.temp,
                condition: weatherResponse.weather.first?.description ?? "")
        } catch {
            print("Error fetching weather data: \(error.localizedDescription)")        }
    }
}

#Preview {
    WeatherView()
}
