//
//  PhaseAnimatorsView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct PhaseAnimatorsView: View {
    var body: some View {
        card(.green, "Scale", GreenPhaseAnimatorModifier())
    }
}

private extension PhaseAnimatorsView {
    func card(_ color : Color, _ title : String, _ viewModifier : some ViewModifier) -> some View {
        VStack {
            color
                .frame(width: 150, height: 150)
                .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                .modifier(viewModifier)
            
            Text(title)
                .font(.title)
                .fontWeight(.ultraLight)
        }
    }
}

private extension PhaseAnimatorsView {
    struct GreenPhaseAnimatorModifier : ViewModifier {
        enum GreenAnimationPhase: CaseIterable {
            case start, middle, end
            
            var scale : CGFloat {
                switch self {
                case .start:
                    1
                case .middle:
                    1.5
                case .end:
                    1
                }
            }
        }
        
        @State private var greenToggle : Bool = false
        
        func body(content: Content) -> some View {
            content
                .phaseAnimator(GreenAnimationPhase.allCases,
                               trigger: greenToggle) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                }
                               .onTapGesture {
                                   greenToggle.toggle()
                               }
        }
    }
}

#Preview {
    PhaseAnimatorsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
