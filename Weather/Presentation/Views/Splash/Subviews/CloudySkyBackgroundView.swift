//
//  CloudySkyBackgroundView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct CloudySkyBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.6), Color.gray.opacity(0.5)]),
                       startPoint: .top,
                       endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
    }
}
