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
            HStack(spacing: 44) {
                card(.green,
                     "Scale",
                     GreenPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
                
                card(.pink,
                     "Scale In & Move",
                     PinkPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
                
                card(.indigo,
                     "Scale In & Move",
                     IndigoPhaseAnimatorModifier(animation: animationType.animation(withDuration: animationDuration)))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Divider()
            
            AnimationControllerView(animationType: $animationType.optional,
                                    animationDuration: $animationDuration)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 80)
    }
}

private extension PhaseAnimatorsView {
    func card(_ color : Color, _ title : String, _ viewModifier : some ViewModifier) -> some View {
        VStack {
            color
                .frame(width: 200, height: 200)
                .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                .modifier(viewModifier)
            
            Text(title)
                .font(.title)
                .fontWeight(.ultraLight)
        }
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
                        .disabled(phase != .initial)
                } animation: { _ in animation }
        }
    }
}

#Preview {
    PhaseAnimatorsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
