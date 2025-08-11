//
//  backgroundLayer.swift
//  WeatherApp
//
//  Created by User on 5/25/25.
//

import SwiftUI

struct BackgroundLayer: View {
    @ObservedObject var viewModel : WeatherViewModel
    var gradientLayer: some View {
        let condition = viewModel.weather?.weather.first?.main ?? "Clear"
        let colors: [Color] = {
            switch condition {
            case "Clouds":
                return [Color.gray, Color.blue.opacity(0.5)]
            case "Rain":
                return [Color.blue, Color.gray]
            case "Clear":
                return [Color.yellow, Color.orange]
            default:
                return [Color.pink, Color.cyan] // Changed to hot pink for debug visibility
            }
        }()
        return LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .animation(.easeInOut(duration: 2), value: condition)
        .ignoresSafeArea()
    }
    var body: some View {
        ZStack {
            gradientLayer
            let condition = viewModel.weather?.weather.first?.main ?? "Clear"
            if condition == "Rain" {
                RainEffectView()
            } else if condition == "Clouds" {
                CloudEffectView()
            } else if condition == "Clear" {
                SunEffectView()
            }
            AnimatedWeatherFaceView(condition: condition)
        }
    }
}

struct RainEffectView: View {
    @State private var rainOffset: CGFloat = -300

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<50, id: \.self) { i in
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 2, height: 10)
                    .position(x: CGFloat.random(in: 0...geometry.size.width),
                              y: rainOffset)
                    .animation(
                        Animation.linear(duration: Double.random(in: 1...2))
                            .repeatForever(autoreverses: false)
                            .delay(Double(i) * 0.1),
                        value: rainOffset
                    )
            }
        }
        .onAppear {
            rainOffset = UIScreen.main.bounds.height + 100
        }
    }
}

struct CloudEffectView: View {
    @State private var cloudOffset: CGFloat = -200

    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 100)
            .foregroundColor(.white.opacity(0.5))
            .offset(x: cloudOffset)
            .onAppear {
                withAnimation(Animation.linear(duration: 20).repeatForever(autoreverses: false)) {
                    cloudOffset = UIScreen.main.bounds.width + 200
                }
            }
    }
}

struct SunEffectView: View {
    @State private var pulse = false

    var body: some View {
        Circle()
            .fill(Color.yellow)
            .frame(width: 100, height: 100)
            .scaleEffect(pulse ? 1.2 : 1)
            .opacity(pulse ? 0.8 : 1)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    pulse.toggle()
                }
            }
    }
}

#Preview {
    BackgroundLayer(viewModel: WeatherViewModel())
}


struct AnimatedWeatherFaceView: View {
    let condition: String
    @State private var mouthOffset: CGFloat = 0

    var body: some View {
        VStack {
            ZStack {
                // Face circle (skin tone)
                Circle()
                    .fill(Color(red: 1.0, green: 0.87, blue: 0.77))
                    .frame(width: 140, height: 140)
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                    )

                // Eyes
                HStack(spacing: 40) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 12, height: 12)
                    Circle()
                        .fill(Color.black)
                        .frame(width: 12, height: 12)
                }
                .offset(y: -25)

                // Eyebrows
                HStack(spacing: 40) {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 20, height: 4)
                        .rotationEffect(.degrees(condition == "Rain" ? 20 : (condition == "Clear" ? -10 : 0)))
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 20, height: 4)
                        .rotationEffect(.degrees(condition == "Rain" ? -20 : (condition == "Clear" ? 10 : 0)))
                }
                .offset(y: -40)

                // Nose
                Capsule()
                    .fill(Color.black.opacity(0.7))
                    .frame(width: 6, height: 20)
                    .offset(y: -5)

                // Mouth
                Path { path in
                    let mouthWidth: CGFloat = 50
                    let mouthHeight: CGFloat = condition == "Rain" ? -12 : (condition == "Clear" ? 12 : 0)
                    path.move(to: CGPoint(x: -mouthWidth / 2, y: 0))
                    path.addQuadCurve(to: CGPoint(x: mouthWidth / 2, y: 0),
                                      control: CGPoint(x: 0, y: mouthHeight + mouthOffset))
                }
                .stroke(Color.black, lineWidth: 2)
                .frame(width: 60, height: 30)
                .offset(y: 35)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    mouthOffset = condition == "Rain" ? -3 : (condition == "Clear" ? 3 : 0)
                }
            }

            Text(condition == "Clear" ? "Sunny and Happy"
                 : condition == "Rain" ? "Rainy and Sad"
                 : "Cloudy and Neutral")
                .foregroundColor(.white)
                .font(.caption)
                .padding(.top, 5)
        }
    }
}
