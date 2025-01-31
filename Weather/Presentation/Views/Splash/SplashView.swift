//
//  SplashView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import SwiftUI

struct SplashView: View {
    @State private var showRain: Bool = true
    @State private var sunOffset: CGFloat = UIScreen.main.bounds.height
    @State private var sunScale: CGFloat = 0.0
    @State private var showAppName = false

    var body: some View {
        ZStack(alignment: .top) {
            if showRain {
                CloudySkyBackgroundView()
                    .accessibilityIdentifier("cloudySkyBackgroundView")
                rainComponent
            } else {
                SkyBackgroundView()
                    .accessibilityIdentifier("skyBackgroundView")
            }
            sunComponent
            appName
        }
    }
}

// MARK: rainComponent
extension SplashView {
    var rainComponent: some View {
        HStack {
            ForEach(0..<50, id: \.self) { _ in
                Raindrop()
            }
        }
        .ignoresSafeArea()
        .accessibilityIdentifier("rainComponent")
    }
}

// MARK: sunComponent
extension SplashView {
    var sunComponent: some View {
        HStack {
            Spacer()
            Image(systemName: WeatherContants.Icons.sun)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .offset(y: sunOffset)
                .foregroundColor(Color.yellow)
                .scaleEffect(sunScale)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.5).delay(1.0)) {
                        sunOffset = 30.0
                        sunScale = 1.0
                        showRain = false
                    }
                }
        }
        .padding(.trailing, 30.0)
        .accessibilityIdentifier("sunComponent")
    }
}

// MARK: appName
extension SplashView {
    var appName: some View {
        VStack {
            Spacer()
            Text(WeatherContants.Strings.appName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        .opacity(showAppName ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 2.0).delay(1.5)) {
                showAppName = true
            }
        }
        .accessibilityIdentifier("appName")
    }
}

#Preview {
    SplashView()
}
