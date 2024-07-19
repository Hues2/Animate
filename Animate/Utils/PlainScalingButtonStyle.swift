//
//  PlainScalingButtonStyle.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct PlainScalingButtonStyle : ButtonStyle {
    @State private var scale : CGFloat = 1
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scale)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                withAnimation {
                    self.scale = newValue ? 0.8 : 1
                }
            }
    }
}
