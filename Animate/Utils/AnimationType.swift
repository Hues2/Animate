//
//  AnimationType.swift
//  Animate
//
//  Created by Greg Ross on 21/07/2024.
//

import SwiftUI

enum AnimationType : String, Identifiable, CaseIterable {
    case easeInOut, smooth, snappy, bouncy
    
    var id : String { self.rawValue }
    
    var displayString : String {
        switch self {
        case .easeInOut: return "Ease In/Out"
        case .smooth: return "Smooth"
        case .snappy: return "Snappy"
        case .bouncy: return "Bouncy"
        }
    }
    
    func animation(withDuration duration: Double) -> Animation {
        switch self {
        case .easeInOut: return .easeInOut(duration: duration)
        case .smooth: return .linear(duration: duration)
        case .snappy: return .interactiveSpring(response: duration, dampingFraction: 0.5, blendDuration: 0.5)
        case .bouncy: return .spring(response: duration, dampingFraction: 0.5, blendDuration: 0.5)
        }
    }
}
