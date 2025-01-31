//
//  ContentView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject var favoriteLocationsViewModel = FavoriteLocationsViewModel(
        context: PersistenceController.shared.viewContext
    )
    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                tabView
                    .accessibilityIdentifier("tabView")
            } else {
                SplashView()
                    .accessibilityIdentifier("splashView")
            }
        }
        .environmentObject(favoriteLocationsViewModel)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isActive = true
            }
        }
    }

    private var tabView: some View {
        TabView {
            SearchLocationView(dependencyContainer: DependencyContainer.shared)
                .tabItem {
                    Label(
                        WeatherContants.Strings.searchLocation,
                        systemImage: WeatherContants.Icons.search
                    )
                }
                .accessibilityIdentifier("searchLocationView")

            FavoriteLocationsView()
                .tabItem {
                    Label(
                        WeatherContants.Strings.favorites,
                        systemImage: WeatherContants.Icons.notFavorite
                    )
                }
                .accessibilityIdentifier("favoriteLocationsView")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(
            FavoriteLocationsViewModel(
                context: PersistenceController.preview.viewContext
            )
        )
}
