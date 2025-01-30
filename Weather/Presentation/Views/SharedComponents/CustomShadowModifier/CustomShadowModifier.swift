//
//  CustomShadowModifier.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct CustomShadowModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    var x: CGFloat
    var y: CGFloat

    init(color: Color = .black, radius: CGFloat = 2, x: CGFloat = 1, y: CGFloat = 1) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension View {
    func customShadow(color: Color = .black, radius: CGFloat = 2, x: CGFloat = 1, y: CGFloat = 1) -> some View {
        self.modifier(CustomShadowModifier(color: color, radius: radius, x: x, y: y))
    }
}

