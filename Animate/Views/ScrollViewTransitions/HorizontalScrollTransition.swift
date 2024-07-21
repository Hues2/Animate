//
//  HorizontalScrollTransition.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct HorizontalScrollTransition: View {
    let colors : [Color]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(Array(zip(0..<colors.count, colors)), id: \.0) { _, color in
                    card(color)
                        .scrollTransition { view, phase in
                            view
                                .scaleEffect(phase.isIdentity ? 1 : 0.2)
                                .rotationEffect(Angle(degrees: phase.isIdentity ? 0 : 180))
                                .opacity(phase.isIdentity ? 1 : 0.2)
                        }
                }
                .scrollTargetLayout()
            }
            .frame(maxHeight: .infinity)
        }
        .contentMargins(32)
    }
}

private extension HorizontalScrollTransition {
    func card(_ color : Color) -> some View {
        ZStack {
            color
                .frame(width: 480, height: 324)
                .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
            
            Text("Random Text")
                .font(.title)
                .fontWeight(.ultraLight)
        }
    }
}

#Preview {
    HorizontalScrollTransition(colors: [.green, .pink, .blue, .orange, .yellow,
                                        .red, .purple, .cyan, .indigo, .mint,
                                        .black, .green, .pink, .blue, .orange,
                                        .yellow, .red, .purple])
}
