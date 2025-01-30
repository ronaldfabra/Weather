//
//  SkyBackgroundView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct SkyBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white, Color.orange]),
                       startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
}
