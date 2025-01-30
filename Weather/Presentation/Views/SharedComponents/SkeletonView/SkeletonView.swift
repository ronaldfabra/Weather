//
//  SkeletonView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .shimmering()
    }
}

#Preview {
    SkeletonView()
        .frame(height: 40)
        .padding()
}
