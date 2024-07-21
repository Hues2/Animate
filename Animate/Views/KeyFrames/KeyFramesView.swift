//
//  KeyFramesView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct KeyFramesView: View {
    private let iconSize : CGFloat = 124
    private let animationDuration : CGFloat = 1.0
    // Checkmarck
    @State private var checkmarkToggle : Bool = false
    private let checkmarkRotationAmount : CGFloat = 360
    // Heart
    @State private var heartToggle : Bool = false
    // Warning
    @State private var warningToggle : Bool = false
    private let warningRotationAmount : CGFloat = 20
    // Trash
    @State private var trashToggle : Bool = false
    private let trashRotationAmount : CGFloat = 360
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 0) {
                basketball
                    .frame(maxWidth: .infinity)
                checkmark
                    .frame(maxWidth: .infinity)
                heart
                    .frame(maxWidth: .infinity)
                warning
                    .frame(maxWidth: .infinity)
                trash
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            hint
        }
        .frame(maxWidth: .infinity)
    }
}

private extension KeyFramesView {
    func icon(_ iconName : String, _ color : Color) -> some View {
        Image(systemName: iconName)
            .resizable()
            .symbolVariant(.fill)
            .foregroundStyle(color)
            .frame(width: 100, height: 100)
    }
    
    var hint : some View {
        HStack {
            Text("Tap on the icons")
                .foregroundStyle(.primary)
            Image(systemName: "hand.tap")
                .foregroundStyle(.secondary)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  repeating: true) { content, value in
                    content
                        .scaleEffect(value.scale)
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(1, duration: 0.5)
                        CubicKeyframe(1, duration: 2)
                    }
                }

        }
        .font(.title)
        .fontWeight(.ultraLight)
    }
}

// MARK: Basketball
private extension KeyFramesView {
    var basketball : some View {
        VStack(spacing: 12) {
            icon("basketball.fill", .orange)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  repeating: true) { content, value in
                    content
                        .scaleEffect(y: value.scale, anchor: .bottom)
                        .offset(y: value.yOffset)
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.85, duration: animationDuration * 0.15)
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
            
            Text("Basketball")
                .font(.headline)
        }
    }
}

// MARK: Checkmark
private extension KeyFramesView {
    var checkmark : some View {
        VStack(spacing: 12) {
            icon("checkmark.circle", .green)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  trigger: checkmarkToggle) { content, value in
                    content
                        .offset(y: value.yOffset)
                        .rotation3DEffect(.init(degrees: value.rotationDegrees3D),
                                          axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                } keyframes: { _ in
                    KeyframeTrack(\.yOffset) {
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(-100, duration: animationDuration * 0.33)
                        CubicKeyframe(0, duration: animationDuration * 0.33)
                    }
                    
                    KeyframeTrack(\.rotationDegrees3D) {
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(checkmarkRotationAmount,
                                      duration: animationDuration * 0.33)
                        CubicKeyframe(checkmarkRotationAmount,
                                      duration: animationDuration * 0.33)
                    }
                }
                .onTapGesture {
                    checkmarkToggle.toggle()
                }
            
            Text("Checkmark")
                .font(.headline)
        }
    }
}

// MARK: Heart
private extension KeyFramesView {
    var heart : some View {
        VStack(spacing: 12) {
            icon("heart", .pink)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  trigger: heartToggle) { content, value in
                    content
                        .scaleEffect(value.scale)
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        SpringKeyframe(1.6, duration: animationDuration * 0.25)
                        SpringKeyframe(1, duration: animationDuration * 0.25)
                        SpringKeyframe(1.4, duration: animationDuration * 0.25)
                        SpringKeyframe(1, duration: animationDuration * 0.25)
                        SpringKeyframe(1.2, duration: animationDuration * 0.25)
                        SpringKeyframe(1, duration: animationDuration * 0.25)
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
    var warning : some View {
        VStack(spacing: 12) {
            icon("exclamationmark.triangle.fill", .yellow)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  trigger: warningToggle) { content, value in
                    content
                        .scaleEffect(value.scale)
                        .rotationEffect(.init(degrees: value.rotationDegrees))
                } keyframes: { _ in
                    KeyframeTrack(\.rotationDegrees) {
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.25)
                        CubicKeyframe(warningRotationAmount,
                                      duration: animationDuration * 0.1)
                        CubicKeyframe(-warningRotationAmount,
                                      duration: animationDuration * 0.1)
                        CubicKeyframe(warningRotationAmount,
                                      duration: animationDuration * 0.1)
                        CubicKeyframe(-warningRotationAmount,
                                      duration: animationDuration * 0.1)
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.1)
                        CubicKeyframe(.zero,
                                      duration: animationDuration * 0.25)
                    }
                    
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.4, duration: animationDuration * 0.33)
                        CubicKeyframe(1.4, duration: animationDuration * 0.33)
                        CubicKeyframe(1, duration: animationDuration * 0.33)
                    }
                }
                .onTapGesture {
                    warningToggle.toggle()
                }
            
            Text("Warning")
                .font(.headline)
        }
    }
}

// MARK: Trash
private extension KeyFramesView {
    var trash : some View {
        VStack(spacing: 12) {
            icon("trash.fill", .red)
                .keyframeAnimator(initialValue: AnimatableValues(),
                                  trigger: trashToggle) { content, value in
                    content
                        .offset(x: value.xOffset, y: value.yOffset)
                        .rotationEffect(.init(degrees: value.rotationDegrees))
                } keyframes: { _ in
                    KeyframeTrack(\.yOffset) {
                        CubicKeyframe(-100, duration: animationDuration * 0.2)
                        CubicKeyframe(-100, duration: animationDuration * 1.6)
                        CubicKeyframe(0, duration: animationDuration * 0.2)
                    }
                    
                    KeyframeTrack(\.rotationDegrees) {
                        CubicKeyframe(0, duration: 0.2) // 1
                        CubicKeyframe(0, duration: 0.2) // 2
                        CubicKeyframe(45, duration: 0.2) // 3
                        CubicKeyframe(0, duration: 0.2) // 4
                        CubicKeyframe(0, duration: 0.2) // 5
                        CubicKeyframe(0, duration: 0.2) // 6
                        CubicKeyframe(-45, duration: 0.2) // 7
                        CubicKeyframe(0, duration: 0.2) // 8
                        CubicKeyframe(0, duration: 0.2) // 9
                    }
                    
                    KeyframeTrack(\.xOffset) {
                        CubicKeyframe(0, duration: 0.2) // 1
                        CubicKeyframe(100, duration: 0.2) // 2
                        CubicKeyframe(100, duration: 0.2) // 3
                        CubicKeyframe(100, duration: 0.2) // 4
                        CubicKeyframe(0, duration: 0.2) // 5
                        CubicKeyframe(-100, duration: 0.2) // 6
                        CubicKeyframe(-100, duration: 0.2) // 7
                        CubicKeyframe(-100, duration: 0.2) // 8
                        CubicKeyframe(0, duration: 0.2) // 9
                    }
                }
                .onTapGesture {
                    trashToggle.toggle()
                }
            
            Text("Warning")
                .font(.headline)
        }
    }
}

private extension KeyFramesView {
    struct AnimatableValues {
        var yOffset = 0.0
        var xOffset = 0.0
        var verticalStretch = 1.0
        var rotationDegrees : CGFloat = .zero
        var rotationDegrees3D : CGFloat = .zero
        var scale : CGFloat = 1
    }
}

#Preview {
    KeyFramesView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
