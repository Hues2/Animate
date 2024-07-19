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
            VStack {
                ForEach(Array(zip(0..<colors.count, colors)), id: \.0) { _, color in
                    card(color)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private extension VerticalScrollTransition {
    func card(_ color : Color) -> some View {
        color
            .frame(width: 324, height: 324)
            .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
    }
}

#Preview {
    VerticalScrollTransition(colors: [.green, .pink, .blue, .orange, .yellow, .red, .purple, .cyan, .indigo, .mint, .white, .black, .green, .pink, .blue, .orange, .yellow, .red, .purple])
}
