//
//  PhaseAnimatorsView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct PhaseAnimatorsView: View {
    @State private var greenToggle : Bool = false
    
    var body: some View {
        green
    }
}

private extension PhaseAnimatorsView {
    func card(_ color : Color) -> some View {
        color
            .frame(width: 150, height: 150)
            .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
    }
}

// MARK: Green
private extension PhaseAnimatorsView {
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
    
    var green : some View {
        card(.green)
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

#Preview {
    PhaseAnimatorsView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
