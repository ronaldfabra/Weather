//
//  WeatherDetailView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import CoreData
import SwiftUI

struct WeatherDetailView: View {

    @StateObject var viewModel: WeatherDetailViewModel
    @EnvironmentObject var favoritesViewModel: FavoriteLocationsViewModel

    init(
        location: LocationDomainModel,
        dependencyContainer: DependencyContainerProtocol
    ) {
        self._viewModel = StateObject(
            wrappedValue: dependencyContainer.makeWeatherDetailViewModel(location: location)
        )
    }

    var body: some View {
        ZStack {
            backgroundImage
            contentView
                .foregroundColor(Color.white)
                .onAppear {
                    viewModel.fetchWeatherDetail()
                }
        }
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: backgroundImage
extension WeatherDetailView {
    var backgroundImage: some View {
        GeometryReader { reader in
            ZStack {
                if let weather = viewModel.weather {
                    Image(
                        weather.current.condition.weatherCondition
                            .getBackgroundImage()
                    )
                    .resizable()
                    .scaledToFill()
                    .frame(width: reader.size.width,
                           height: reader.size.height)
                    .clipped()
                    Color.black.opacity(0.4)
                        .frame(width: reader.size.width,
                               height: reader.size.height)
                }
            }
            .padding(.top, 1.0)
        }
    }
}

// MARK: contentView
extension WeatherDetailView {
    var contentView: some View {
        VStack {
            if viewModel.isLoading {
                skeletonView
            } else {
                if viewModel.error != .none {
                    errorView
                } else {
                    if let weather = viewModel.weather {
                        weatherComponent(weather: weather)
                    }
                }
            }
        }
    }
}

// MARK: skeletonView
extension WeatherDetailView {
    var skeletonView: some View {
        VStack(spacing: WeatherContants.Dimens.spacing20) {
            SkeletonView().frame(height: 30)
            SkeletonView().frame(height: 70)
            SkeletonView().frame(height: 14)
            SkeletonView().frame(height: 40)
            SkeletonView().frame(height: 100)
            SkeletonView().frame(height: 300)
            Spacer()
        }
        .padding(.vertical, WeatherContants.Dimens.spacing50)
        .padding(.horizontal, WeatherContants.Dimens.spacing20)
    }
}

// MARK: errorView
extension WeatherDetailView {
    var errorView: some View {
        VStack(spacing: WeatherContants.Dimens.spacing20) {
            Image(systemName: viewModel.error.errorIcon)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(Color.red)
            VStack(spacing: WeatherContants.Dimens.spacing20) {
                Text(viewModel.error.errorDescription)
                Button(action: {
                    viewModel.fetchWeatherDetail()
                }) {
                    Text(WeatherContants.Strings.tryAgain)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
                .padding()
            }
            .foregroundColor(.black)
        }
        .multilineTextAlignment(.center)
    }
}

// MARK: weatherComponent
extension WeatherDetailView {
    func weatherComponent(weather:  WeatherDomainModel) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: WeatherContants.Dimens.spacing50) {
                currentWeatherComponent(
                    tempC: weather.current.tempC,
                    condition: weather.current.condition.text,
                    location: weather.location
                )
                VStack(spacing: WeatherContants.Dimens.spacing10) {
                    weatherForHoursComponent(
                        localTime: weather.location.localtime ?? .empty,
                        hours: weather.forecast.forecastday.first?.hours ?? []
                    )
                    forecastComponent(localTime: weather.location.localtime ?? .empty,
                                      forecastday: weather.forecast.forecastday)
                }
            }
            .padding(WeatherContants.Dimens.spacing20)
        }
        .padding(1.0)
    }
}

// MARK: currentWeatherComponent
extension WeatherDetailView {
    func currentWeatherComponent(tempC: Double?, condition: String, location: LocationDomainModel) -> some View {
        VStack(spacing: 6.0) {
            Text(viewModel.weatherLocation)
                .font(.system(size: 18.0, weight: .medium))
                .customShadow()
            Text(WeatherUtils.getTempString(temp: tempC))
                .font(.system(size: 70.0, weight: .semibold))
                .customShadow()
            VStack(spacing: .zero) {
                Text(condition)
                    .customShadow()
                HStack {
                    Text(viewModel.minTemperature)
                        .font(.system(size: 14.0, weight: .light))
                        .customShadow()
                    Text(viewModel.maxTemperature)
                        .font(.system(size: 14.0, weight: .light))
                        .customShadow()
                }
            }
            HStack {
                FavoriteButton(isFavorite: favoritesViewModel.isFavorite(location: viewModel.location)) {
                    favoritesViewModel
                        .updateFavorite(location: viewModel.location)
                }
                LocationButton() {
                    viewModel.openMaps(
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                }
            }
        }
    }
}

// MARK: weatherForHoursComponent
extension WeatherDetailView {
    func weatherForHoursComponent(localTime: String, hours: [CurrentDomainModel]) -> some View {
        VStack {
            Text(viewModel.expectedWeatherForNextHourLabel)
                .font(.system(size: 14.0, weight: .medium))
                .customShadow()
            Divider()
                .background(Color.white)
            listOfWeatherByHoursComponent(localTime: localTime, hours: hours)
        }
        .padding(.horizontal, WeatherContants.Dimens.spacing10)
        .padding(.vertical, WeatherContants.Dimens.spacing10)
        .background(Color.black.opacity(0.4))
        .cornerRadius(15)
    }

    func listOfWeatherByHoursComponent(localTime: String, hours: [CurrentDomainModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: WeatherContants.Dimens.spacing20) {
                ForEach(
                    viewModel.getNextHours(
                        localTime: localTime,
                        currents: hours
                    )
                ) { hour in
                    VStack(spacing: 5.0) {
                        Text(
                            WeatherUtils.getHourFromDate(
                                locationDate: localTime,
                                dateStr: hour.time ?? .empty
                            )
                        )
                        .font(.system(size: 14.0, weight: .medium))
                        .customShadow()
                        conditionIcon(conditionIcon: hour.condition.icon)
                        Text(WeatherUtils.getTempString(temp: hour.tempC))
                            .font(.system(size: 16.0, weight: .medium))
                            .customShadow()
                    }
                }
            }
        }
    }
}

// MARK: forecastComponent
extension WeatherDetailView {
    func forecastComponent(localTime: String, forecastday: [ForecastdayDomainModel]) -> some View {
        VStack {
            VStack {
                Text(viewModel.daysForecastLabel)
                    .font(.system(size: 15.0, weight: .semibold))
                    .customShadow()
            }
            .frame(maxWidth: .infinity)
            .padding(WeatherContants.Dimens.spacing10)
            .background(Color.black.opacity(0.4))
            .cornerRadius(15)
            ForEach(forecastday) { day in
                forecastRow(
                    localTime: localTime,
                    forecastDay: day
                )
            }
        }
    }

    func forecastRow(localTime: String, forecastDay: ForecastdayDomainModel) -> some View {
        VStack(spacing: 5.0) {
            Text(
                WeatherUtils.getDayName(
                    locationDate: localTime,
                    dateStr: forecastDay.date
                )
            )
            .font(.system(size: 18.0, weight: .semibold))
            .customShadow()
            conditionIcon(conditionIcon: forecastDay.day.condition.icon)
            Text(forecastDay.day.condition.text)
                .font(.system(size: 14.0, weight: .semibold))
                .customShadow()
            Text(WeatherUtils.getTempString(temp: forecastDay.day.avgtempC))
                .font(.system(size: 40.0, weight: .semibold))
                .customShadow()
            TemperatureBarView(weatherData: forecastDay.day)
        }
        .frame(maxWidth: .infinity)
        .padding(WeatherContants.Dimens.spacing10)
        .background(Color.black.opacity(0.4))
        .cornerRadius(15)
    }
}

// MARK: conditionIcon
extension WeatherDetailView {
    func conditionIcon(conditionIcon: String) -> some View {
        if let conditionUrl = WeatherUtils.getConditionIconUrl(
            conditionIcon: conditionIcon
        ) {
            if #available(iOS 15.0, *) {
                return AnyView(
                    AsyncImage(url: conditionUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle.fill")
                        @unknown default:
                            EmptyView()
                        }
                    }
                )
            } else {
                return AnyView(RemoteImageView(url: conditionUrl))
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}

#Preview {
    WeatherDetailView(location: .init(id: 0,
                                      name: "Santa Marta",
                                      country: "Colombia",
                                      latitude: 10.96,
                                      longitude: -74.80,
                                      localtime: ""),
                      dependencyContainer: DependencyContainer.shared)
    .environmentObject(
        FavoriteLocationsViewModel(
            context: PersistenceController.preview.viewContext
        )
    )
}
