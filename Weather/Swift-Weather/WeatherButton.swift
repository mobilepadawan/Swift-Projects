//
//  WeatherButton.swift
//  Swift-Weather
//
//  Created by Fernando Luna on 05/04/2024.
//
import SwiftUI

struct WeatherButton: View {
    
    var title: String
    @Binding var isNight: Bool

    var body: some View {
        Button {
        } label: {
            Text(title)
                .frame(width: 280, height: 50)
                .background(isNight ? Color("darkgray") : .blue)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold, design: .default)
                )
                .cornerRadius(10)
        }
    }
}
