//
//  AppScreen.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

enum AppScreen : String, Identifiable, Hashable, CaseIterable {
    case basics
    case transitions
    case matchedGeometry
    case scrollTransitions
    case keyFrames
    case phaseAnimators
    
    var id : String { self.rawValue }
    
    var sideBarString : String {
        switch self {
        case .basics: return "Basics"
        case .transitions: return "Transitions"
        case .matchedGeometry: return "Matched Geometry Effect"
        case .scrollTransitions: return "ScrollView Transitions (iOS 17.0+)"
        case .keyFrames: return "Key Frames (iOS 17.0+)"
        case .phaseAnimators: return "Phase Animators (iOS 17.0+)"
        }
    }
    
    @ViewBuilder
    var detailView : some View {
        switch self {
        case .basics:
            BasicsView()
        case .transitions:
            TransitionsView()
        case .matchedGeometry:
            MatchedGeometryView()
        case .scrollTransitions:
            ScrollTransitionsView()
        case .keyFrames:
            KeyFramesView()
        case .phaseAnimators:
            PhaseAnimatorsView()
        }
    }
}
