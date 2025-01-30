//
//  View+Extension.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

extension View {
    func shimmering() -> some View {
        self.overlay(
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.2), Color.white.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .rotationEffect(.degrees(30))
            .offset(x: -200, y: -200)
            .mask(self)
            .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: UUID())
        )
    }
}
