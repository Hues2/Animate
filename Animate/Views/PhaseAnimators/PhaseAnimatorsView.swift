//
//  PhaseAnimatorsView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct PhaseAnimatorsView: View {
    @State private var animationType : AnimationType = .easeInOut
    @State private var animationDuration : CGFloat = 1.2
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
                card(.green,
                     GreenPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
                
                card(.pink,
                     PinkPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
                
                card(.orange,
                     OrangePhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
                
                card(.indigo,
                     IndigoPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 24)
            
            Divider()
            
            AnimationControllerView(animationType: $animationType.optional,
                                    animationDuration: $animationDuration)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
    }
}

private extension PhaseAnimatorsView {
    func card(_ color : Color, _ viewModifier : some ViewModifier) -> some View {
        color
            .frame(width: 200, height: 200)
            .overlay(alignment: .topTrailing) {
                Image(systemName: "hand.tap")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(.primary)
                    .padding()
            }
            .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
            .modifier(viewModifier)
            .frame(maxWidth: .infinity)
    }
}

// MARK: Green
private extension PhaseAnimatorsView {
    struct GreenPhaseAnimatorModifier : ViewModifier {
        private enum GreenAnimationPhase: CaseIterable {
            case initial, middle, end
            
            var scale : CGFloat {
                switch self {
                case .initial: 1
                case .middle: 1.5
                case .end: 1
                }
            }
        }
        
        let animation : Animation
        @State private var toggle : Bool = false
        
        func body(content: Content) -> some View {
            content
                .onTapGesture {
                    toggle.toggle()
                }
                .phaseAnimator(GreenAnimationPhase.allCases,
                               trigger: toggle) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .disabled(phase != .initial)
                } animation: { _ in animation }
        }
    }
}

// MARK: Pink
private extension PhaseAnimatorsView {
    struct PinkPhaseAnimatorModifier : ViewModifier {
        private enum PinkAnimationPhase: CaseIterable {
            case initial, scaleIn, moveLeft, moveRight, scaleOut
            
            var scale : CGFloat {
                switch self {
                case .initial: 1
                case .scaleIn: 1.5
                case .moveLeft: 1.5
                case .moveRight: 1.5
                case .scaleOut: 1
                }
            }
            
            var xOffset : CGFloat {
                switch self {
                case .initial: 0
                case .scaleIn: 0
                case .moveLeft: -100
                case .moveRight: 100
                case .scaleOut: 0
                }
            }
            
            var blur : CGFloat {
                switch self {
                case .initial: 0
                case .scaleIn: 0
                case .moveLeft: 4
                case .moveRight: 4
                case .scaleOut: 0
                }
            }
        }
        
        let animation : Animation
        @State private var toggle : Bool = false
        
        func body(content: Content) -> some View {
            content
                .onTapGesture {
                    toggle.toggle()
                }
                .phaseAnimator(PinkAnimationPhase.allCases,
                               trigger: toggle) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .offset(x: phase.xOffset)
                        .blur(radius: phase.blur)
                        .disabled(phase != .initial)
                } animation: { _ in animation }
        }
    }
}

// MARK: Orange
private extension PhaseAnimatorsView {
    struct OrangePhaseAnimatorModifier : ViewModifier {
        private enum OrangeAnimationPhase: CaseIterable {
            case initial, first, second, third, end
            
            var scale : CGFloat {
                switch self {
                case .initial: 1
                case .first: 1.5
                case .second: 1
                case .third: 1.5
                case .end: 1
                }
            }
            
            var yOffset : CGFloat {
                switch self {
                case .initial: 0
                case .first: 100
                case .second: 0
                case .third: -100
                case .end: 0
                }
            }
            
            var degrees : CGFloat {
                switch self {
                case .initial: 0
                case .first: 360
                case .second: 0
                case .third: -360
                case .end: 0
                }
            }
        }
        
        let animation : Animation
        @State private var toggle : Bool = false
        
        func body(content: Content) -> some View {
            content
                .onTapGesture {
                    toggle.toggle()
                }
                .phaseAnimator(OrangeAnimationPhase.allCases,
                               trigger: toggle) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .offset(y: phase.yOffset)
                        .rotationEffect(.init(degrees: phase.degrees))
                        .disabled(phase != .initial)
                } animation: { _ in animation }
        }
    }
}

// MARK: Indigo
private extension PhaseAnimatorsView {
    struct IndigoPhaseAnimatorModifier : ViewModifier {
        private enum IndigoAnimationPhase: CaseIterable {
            case initial
            case scaleInAndMoveUp
            case moveLeft
            case moveDown
            case moveRight
            case moveUp
            case moveCenter
            case scaleDownAndMoveDown
            
            var scale : CGFloat {
                switch self {
                case .initial: 1
                case .scaleInAndMoveUp: 1.5
                case .moveLeft: 1.5
                case .moveDown: 1.5
                case .moveRight: 1.5
                case .moveUp: 1.5
                case .moveCenter: 1.5
                case .scaleDownAndMoveDown: 1
                }
            }
            
            var xOffset : CGFloat {
                switch self {
                case .initial: 0
                case .scaleInAndMoveUp: 0
                case .moveLeft: -100
                case .moveDown: -100
                case .moveRight: 100
                case .moveUp: 100
                case .moveCenter: 0
                case .scaleDownAndMoveDown: 0
                }
            }
            
            var yOffset : CGFloat {
                switch self {
                case .initial: 0
                case .scaleInAndMoveUp: -100
                case .moveLeft: -100
                case .moveDown: 100
                case .moveRight: 100
                case .moveUp: -100
                case .moveCenter: -100
                case .scaleDownAndMoveDown: 0
                }
            }
            
            var degrees : CGFloat {
                switch self {
                case .initial: 0
                case .scaleInAndMoveUp: 0
                case .moveLeft: 10
                case .moveDown: 10
                case .moveRight: -10
                case .moveUp: -10
                case .moveCenter: 0
                case .scaleDownAndMoveDown: 0
                }
            }
        }
        
        let animation : Animation
        @State private var toggle : Bool = false
        
        func body(content: Content) -> some View {
            content
                .onTapGesture {
                    toggle.toggle()
                }
                .phaseAnimator(IndigoAnimationPhase.allCases,
                               trigger: toggle) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .offset(x: phase.xOffset, y: phase.yOffset)
                        .rotation3DEffect(
                            .init(degrees: phase.degrees),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .disabled(phase != .initial)
                } animation: { _ in animation }
        }
    }
}

#Preview {
    PhaseAnimatorsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
