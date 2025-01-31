//
//  SearchLocationView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import SwiftUI

struct SearchLocationView: View {

    typealias Dimens = WeatherContants.Dimens

    @State private var query: String = .empty
    @StateObject var viewModel: SearchLocationViewModel

    init(dependencyContainer: DependencyContainerProtocol) {
        self._viewModel = StateObject(
            wrappedValue: dependencyContainer.makeSearchLocationViewModel()
        )
    }

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
}

// MARK: bodyView
extension SearchLocationView {
    private var bodyView: some View {
        contentView
            .navigationBarTitle(WeatherContants.Strings.searchLocation,
                                displayMode: .inline
            )
    }
}

// MARK: contentView
extension SearchLocationView {
    private var contentView: some View {
        VStack(spacing: .zero) {
            TextField(WeatherContants.Strings.searchLocation,
                      text: $query)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .accessibilityIdentifier("searchLocationTextfield")
            .onChange(of: query) { newQuery in
                viewModel.updateQuery(query: newQuery)
            }
            if viewModel.isLoading {
                skeletonView
            } else {
                if viewModel.locations.isEmpty {
                    emptyView
                } else {
                    listView
                }
            }
        }
    }
}

// MARK: listView
extension SearchLocationView {
    private var emptyView: some View {
        VStack {
            Spacer()
            VStack {
                Image(WeatherContants.Images.location)
                    .resizable()
                    .frame(width: 150.0, height: 150.0)
                    .accessibilityIdentifier(WeatherContants.Images.location)
                Text(WeatherContants.Strings.EmptyState.Search.title)
                    .font(.system(size: 20.0, weight: .light))
                    .accessibilityIdentifier(WeatherContants.Strings.EmptyState.Search.title)
            }
            Spacer()
        }
        .padding(Dimens.spacing50)
        .multilineTextAlignment(.center)
    }
}

// MARK: listView
extension SearchLocationView {
    private var listView: some View {
        if #available(iOS 16.0, *) {
            AnyView(
                List {
                    ForEach(viewModel.locations, id: \.self) { location in
                        NavigationLink(value: location) {
                            LocationRow(location: location)
                        }
                    }
                }
                    .accessibilityIdentifier("searchLocationListView")
            )
        } else {
            AnyView(
                List(viewModel.locations, id: \.self) { location in
                        NavigationLink(destination: WeatherDetailView(
                            location: location,
                            dependencyContainer: DependencyContainer.shared
                        )) {
                            LocationRow(location: location)
                        }
                    }
                    .accessibilityIdentifier("searchLocationListView")
            )
        }
    }
}

// MARK: skeletonView
extension SearchLocationView {
    var skeletonView: some View {
        VStack(spacing: Dimens.spacing20) {
            SkeletonView().frame(height: Dimens.spacing50)
            SkeletonView().frame(height: Dimens.spacing50)
            SkeletonView().frame(height: Dimens.spacing50)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchLocationView(dependencyContainer: DependencyContainer.shared)
        .environmentObject(
            FavoriteLocationsViewModel(
                context: PersistenceController.preview.viewContext
            )
        )
}
