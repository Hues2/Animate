//
//  AnimationControllerView.swift
//  Animate
//
//  Created by Greg Ross on 21/07/2024.
//

import SwiftUI

struct AnimationControllerView: View {
    @Binding var animationType : AnimationType?
    @Binding var animationDuration : CGFloat
    
    var body: some View {
        VStack(spacing: 40) {
            if let animationType {
                VStack {
                    Text("Animation:")
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    MenuButton(animationType.displayString) {
                        ForEach(AnimationType.allCases) { animationType in
                            Button {
                                withAnimation {
                                    self.animationType = animationType
                                }
                            } label: {
                                Text(animationType.displayString)
                            }
                        }
                    }
                }
            }
            
            VStack {
                Text("Animation Duration: \(String(format: "%.1f", animationDuration))s")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentTransition(.numericText())
                    .animation(.smooth, value: animationDuration)
                Slider(value: $animationDuration, in: 0.2...2, step: 0.2)
            }
        }
        .frame(width: 300)
        .padding(32)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .stroke(.pink)
                .shadow(color: .black, radius: 4)
        }
    }
}
