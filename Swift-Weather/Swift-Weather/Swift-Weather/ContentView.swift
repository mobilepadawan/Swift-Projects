//
//  ContentView.swift
//  Swift-Weather
//
//  Created by Fernando Luna on 05/04/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color("lightblue")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Text("Cupertino, CA")
                    .font(.system(size: 32, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .padding()
                
                VStack(spacing: 8) {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180, height: 120)
                    Text("76º")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 40)
                
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
                
                Spacer()
                
                Button {
                    print("tapped")
                } label: {
                    Text("Change Day Time")
                        .foregroundColor(Color.blue)
                        .frame(width: 280, height: 50)
                        .background(Color.white)
                        .font(.system(size: 20,
                                      weight: .bold,
                                      design: .default)
                        )
                        .cornerRadius(10.0)
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
