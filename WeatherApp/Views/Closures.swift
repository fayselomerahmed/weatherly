//
//  Closures.swift
//  WeatherApp
//
//  Created by User on 5/26/25.
//

import SwiftUI

struct Closures: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Tap me") {
            print("The button was tapped")   // <- this is the closure body
        }
    }
}

#Preview {
    Closures()
}
