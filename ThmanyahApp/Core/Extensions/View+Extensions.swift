//
//  View+Extensions.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cardStyle() -> some View {
        self
            .background(Color.gray.opacity(0.1))
            .cornerRadius(AppConstants.Layout.cornerRadius)
    }
    
    func shimmerEffect() -> some View {
        self
            .overlay(
                RoundedRectangle(cornerRadius: AppConstants.Layout.cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.4), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .rotationEffect(.degrees(30))
                    .offset(x: -200)
                    .animation(
                        .easeInOut(duration: 1.5).repeatForever(autoreverses: false),
                        value: true
                    )
            )
    }
}
