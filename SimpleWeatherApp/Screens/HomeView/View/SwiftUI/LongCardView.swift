//
//  LongCardView.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 26.05.2023.
//

import SwiftUI

struct LongCardView: View {
    var firstData: Double?
    var secondData: Double?
    var text: String
    var firstVText: String
    var secondVText: String
    var unit: String
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
            Spacer()
            VStack {
                if let firstData {
                    Text("\(firstVText): \(String(format: "%.1f \(unit)", firstData))")
                        .font(.body).padding()
                }
                if let secondData {
                    Text("\(secondVText): \(String(format: "%.1f \(unit)", secondData))")
                        .font(.body)
                }
            }
        }
        .background(Color.white)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black, lineWidth: 2)
        )
        
    }
}
