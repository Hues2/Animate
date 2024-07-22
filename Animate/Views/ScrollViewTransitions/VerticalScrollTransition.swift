//
//  VerticalScrollTransition.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct VerticalScrollTransition: View {
    let colors : [Color]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(Array(zip(0..<colors.count, colors)), id: \.0) { _, color in
                    card(color)
                        .scrollTransition { view, phase in
                            view
                                .opacity(phase.isIdentity ? 1 : 0.6)
                                .rotation3DEffect(.degrees(phase.isIdentity ? 0 : 45), axis: (x: 0, y: 1, z: 0))
                                .rotationEffect(.degrees(phase.isIdentity ? 0 : 15))
                                .offset(x: phase.isIdentity ? 0 : -350)
                                .blur(radius: phase.isIdentity ? 0 : 8)
                        }
                }
                .scrollTargetLayout()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private extension VerticalScrollTransition {
    func card(_ color : Color) -> some View {
        ZStack {
            color
                .frame(width: 324, height: 380)
                .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
            
            Text("Random Text")
                .font(.title)
                .fontWeight(.ultraLight)
        }
    }
}

#Preview {
    VerticalScrollTransition(colors: [.green, .pink, .blue, .orange, .yellow, .red, .purple,
                                      .cyan, .indigo, .mint, .black, .green, .pink,
                                      .blue, .orange, .yellow, .red, .purple])
}
