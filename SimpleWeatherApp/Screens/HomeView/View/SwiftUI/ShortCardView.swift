//
//  ShortCardView.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 26.05.2023.
//

import SwiftUI

struct ShortCardView: View {
    var data: Int?
    var text: String
    var percentSign: String
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
            Spacer()
            if let data {
                Text("\(percentSign)\(data)")
                    .font(.body)
            }
        }
        .background(Color.white)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.black, lineWidth: 2)
        )}
}
