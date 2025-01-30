//
//  Raindrop.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct Raindrop: View {
    @State private var dropPosition: CGFloat = -100

    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 1, height: 25)
            .offset(y: dropPosition)
            .onAppear {
                withAnimation(Animation.linear(duration: Double.random(in: 0.5...1.0)).repeatForever(autoreverses: false)) {
                    dropPosition = UIScreen.main.bounds.height
                }
            }
    }
}
