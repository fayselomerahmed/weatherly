//
//  ContentView.swift
//  WeatherApp
//
//  Created by User on 5/25/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var city = ""
    var body: some View {
        NavigationStack {
        ZStack {
        
            BackgroundLayer(viewModel: viewModel)

     
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Enter city", text: $city)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                            .padding(.leading)

                        Button {
                            Task {
                                await viewModel.loadWeather(for: city)
                            }
                        } label: {
                            Text("Search")
                                .padding()
                                .font(.headline)
                                .foregroundStyle(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                        }
                    }
                    .padding(.all, 20)

                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }

                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }

                        if let icon = viewModel.weather?.weather.first?.icon {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                        }

                        if let description = viewModel.weather?.weather.first?.description {
                            Text(description.capitalized)
                                .font(.headline)
                                .foregroundColor(.gray)
                        }

                        Text("\(viewModel.weather?.main.temp ?? 0.0, specifier: "%.1f") °C")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()

                    Spacer()
                }
                .navigationTitle("Weather")
            }

        }
    }
}
#Preview {
    ContentView()
}
