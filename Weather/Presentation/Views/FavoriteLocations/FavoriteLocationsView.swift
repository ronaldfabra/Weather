//
//  FavoriteLocationsView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//


import SwiftUI

struct FavoriteLocationsView: View {
    
    typealias Dimens = WeatherContants.Dimens
    typealias Strings = WeatherContants.Strings
    
    @State private var selectedItem: LocationDomainModel?
    @EnvironmentObject var viewModel: FavoriteLocationsViewModel
    @State private var selectedFavoriteId: Int? = nil
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                bodyView
                    .navigationDestination(
                        for: LocationDomainModel.self
                    ) { location in
                        WeatherDetailView(
                            location: location,
                            dependencyContainer: DependencyContainer.shared
                        )
                    }
            }
        } else {
            NavigationView {
                bodyView
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        viewModel.deleteItem(from: offsets)
    }
}

// MARK: bodyView
extension FavoriteLocationsView {
    private var bodyView: some View {
        VStack {
            contentView
                .navigationBarTitle(Strings.favorites,
                                    displayMode: .inline)
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

// MARK: contentView
extension FavoriteLocationsView {
    private var contentView: some View {
        VStack(spacing: .zero) {
            if viewModel.favorites.isEmpty {
                emptyState
            } else {
                listView
            }
        }
    }
}

// MARK: listView
extension FavoriteLocationsView {
    private var listView: some View {
        if #available(iOS 16.0, *) {
            AnyView(
                List {
                    ForEach(viewModel.favorites, id: \.self) { location in
                        NavigationLink(value: location) {
                            LocationRow(location: location)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
            )
        } else {
            AnyView(
                List {
                    ForEach(viewModel.favorites, id: \.self) { location in
                        NavigationLink(destination: WeatherDetailView(
                            location: location,
                            dependencyContainer: DependencyContainer.shared
                        )) {
                            LocationRow(location: location)
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
            )
        }
    }
}

// MARK: emptyState
extension FavoriteLocationsView {
    private var emptyState: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: Dimens.spacing20) {
                VStack(alignment: .center, spacing: Dimens.spacing10) {
                    Text(Strings.EmptyState.Favorites.title)
                        .font(.system(size: 30.0, weight: .bold))
                    Text(Strings.EmptyState.Favorites.message)
                        .font(.system(size: 20.0, weight: .light))
                }
                HStack(spacing: .zero) {
                    Text(Strings.EmptyState.Favorites.addFavoriteHelper) +
                    Text(Image(systemName: WeatherContants.Icons.favorite)) +
                    Text(Strings.EmptyState.Favorites.button)
                }
                .font(.system(size: 14.0, weight: .light))
            }
            Spacer()
        }
        .padding(.horizontal, Dimens.spacing20)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    FavoriteLocationsView()
        .environmentObject(
            FavoriteLocationsViewModel(
                context: PersistenceController.preview.viewContext
            )
        )
}
