//
//  ContentView.swift
//  Swift-Weather
//
//  Created by Fernando Luna on 05/04/2024.
//

import SwiftUI

/*
struct Weather: Identifiable {
    let id = UUID()
    var date: String
    var temperature: Int
    var weatherIcon: String
    var humidity: Int
}

class WeatherWeek: ObservedObject {
    @Published var weathers: [Weather] = [
        Weather(date: "SAT", temperature: 27, weatherIcon: "cloud.fill", humidity: 67),
        Weather(date: "SUN", temperature: 32, weatherIcon: "cloud.sun.fill", humidity: 61),
        Weather(date: "MON", temperature: 37, weatherIcon: "sun.max.fill", humidity: 58),
        Weather(date: "TUE", temperature: 35, weatherIcon: "sun.max.fill", humidity: 62),
        Weather(date: "WED", temperature: 33, weatherIcon: "cloud.fill", humidity: 60),
        Weather(date: "THU", temperature: 29, weatherIcon: "cloud.fill", humidity: 49),
    ]
}
*/

struct ContentView: View {

    @State var isNight = true 

    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                CityTextView(cityName: "Buenos Aires, AR")
                MainWeatherStatusView(imageName: isNight ? "moon.fill" : "cloud.sun.fill",
                                      temperature: 27)
                
                HStack(spacing: 20) {
                    WeatherView(dayOfWeek: "TUE",
                                imageName: "cloud.sun.fill",
                                temperature: 32)

                    WeatherView(dayOfWeek: "WED",
                                imageName: "sun.max.fill",
                                temperature: 37)

                    WeatherView(dayOfWeek: "THU",
                                imageName: "sun.max.fill",
                                temperature: 35)

                    WeatherView(dayOfWeek: "FRI",
                                imageName: "sun.max.fill",
                                temperature: 33)

                    WeatherView(dayOfWeek: "SAT",
                                imageName: "cloud.fill",
                                temperature: 29)
                }
                .padding(.top, 80)
                
                Spacer()
                
                WeatherButton(title: "Change Date Time", 
                              isNight: $isNight).onTapGesture {
                    isNight = !isNight
                }
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text(dayOfWeek)
                .font(.system(size: 16,
                              weight: .medium,
                              design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 30)
            Text("\(temperature)º")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : Color("darkblue"),
                                                   isNight ? Color("darkgray") : .blue,
                                                   isNight ? .gray : Color("lightblue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 120)
            Text("\(temperature)º")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.top, 30)
        .padding(.bottom, 20)

    }
}
