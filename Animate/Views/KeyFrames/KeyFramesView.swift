//
//  KeyFramesView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct KeyFramesView: View {
    private let animationDuration : CGFloat = 1.0
    // Heart
    @State private var heartToggle : Bool = false
    private let heartRotationAmount : CGFloat = 180
    // Warning
    @State private var warningToggle : Bool = false
    private let warningRotationAmount : CGFloat = 45
    
    var body: some View {
        VStack {
            HStack(spacing: 52) {
                football
                heart
                warning
            }
            .frame(maxWidth: .infinity)
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: Football
private extension KeyFramesView {
    struct FootballAnimationValues {
        var yOffset = 0.0
        var verticalStretch = 1.0
    }
    
    var football : some View {
        VStack(spacing: 8) {
            Image(systemName: "soccerball")
                .resizable()
                .symbolVariant(.fill)
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.white, .black)
                .frame(width: 100, height: 100)
                .keyframeAnimator(initialValue: FootballAnimationValues(),
                                  repeating: true) { content, value in
                    content
                        .scaleEffect(y: value.verticalStretch, anchor: .bottom)
                        .offset(y: value.yOffset)
                } keyframes: { _ in
                    KeyframeTrack(\.verticalStretch) {
                        CubicKeyframe(0.9, duration: animationDuration * 0.15)
                        CubicKeyframe(1.05, duration: animationDuration * 0.4)
                        CubicKeyframe(1, duration: animationDuration * 0.15)
                        SpringKeyframe(1, duration: animationDuration * 0.15)
                    }
                    
                    KeyframeTrack(\.yOffset) {
                        CubicKeyframe(0, duration: animationDuration * 0.1)
                        CubicKeyframe(-100, duration: animationDuration * 0.3)
                        CubicKeyframe(-100, duration: animationDuration * 0.3)
                        CubicKeyframe(0, duration: animationDuration * 0.3)
                    }
                }
            
            Text("Bouncing Football")
                .font(.headline)
        }
    }
}

// MARK: Heart
private extension KeyFramesView {
    struct HeartAnimationValues {
        var yOffset : CGFloat = .zero
        var rotationDegrees : CGFloat = .zero
        var scale : CGFloat = 1
    }
    
    var heart : some View {
        VStack(spacing: 8) {
            Image(systemName: "heart")
                .resizable()
                .symbolVariant(.fill)
                .foregroundStyle(.pink)
                .frame(width: 100, height: 100)
                .keyframeAnimator(initialValue: HeartAnimationValues(),
                                  trigger: heartToggle) { content, value in
                    content
                        .offset(y: value.yOffset)
                        .scaleEffect(value.scale)
                        .rotation3DEffect(.init(degrees: value.rotationDegrees),
                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                } keyframes: { _ in
                    KeyframeTrack(\.yOffset) {
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(0, duration: animationDuration * 0.33)
                    }
                    
                    KeyframeTrack(\.rotationDegrees) {
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(heartRotationAmount,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(heartRotationAmount,
                                      duration: animationDuration * 0.33)
                    }
                    
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.2, duration: animationDuration * 0.33)
                        CubicKeyframe(1.2, duration: animationDuration * 0.33)
                        CubicKeyframe(1, duration: animationDuration * 0.33)
                    }
                }
                .onTapGesture {
                    heartToggle.toggle()
                }
            
            Text("Heart")
                .font(.headline)
        }
    }
}

// MARK: Warning
private extension KeyFramesView {
    struct WarningAnimationValues {
        var yOffset : CGFloat = .zero
        var rotationDegrees : CGFloat = .zero
        var scale : CGFloat = 1
    }
    
    var warning : some View {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .symbolVariant(.fill)
                .foregroundStyle(.yellow)
                .frame(width: 100, height: 100)
                .keyframeAnimator(initialValue: WarningAnimationValues(),
                                  trigger: heartToggle) { content, value in
                    content
                        .offset(y: value.yOffset)
                        .scaleEffect(value.scale)
                        .rotationEffect(.init(degrees: value.rotationDegrees))
                } keyframes: { _ in
                    KeyframeTrack(\.yOffset) {
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(0, duration: animationDuration * 0.33)
                    }
                    
                    KeyframeTrack(\.rotationDegrees) {
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(warningRotationAmount,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(warningRotationAmount,
                                      duration: animationDuration * 0.33)
                    }
                    
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.2, duration: animationDuration * 0.33)
                        CubicKeyframe(1.2, duration: animationDuration * 0.33)
                        CubicKeyframe(1, duration: animationDuration * 0.33)
                    }
                }
                .onTapGesture {
                    heartToggle.toggle()
                }
            
            Text("Warning")
                .font(.headline)
        }
    }
}

#Preview {
    KeyFramesView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
