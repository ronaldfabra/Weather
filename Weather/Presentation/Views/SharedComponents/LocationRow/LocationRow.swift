//
//  LocationRow.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct LocationRow: View {

    var location: LocationDomainModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.system(size: 18.0, weight: .medium))
            Text(location.country)
                .font(.system(size: 14.0, weight: .medium))
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    LocationRow(
        location: .init(id: 0,
                        name: "Santa Marta",
                        country: "Colombia",
                        latitude: 10.96,
                        longitude: -74.8,
                        localtime: "")
    )
}
