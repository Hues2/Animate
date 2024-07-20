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
    case scrollTransitions
    case matchedGeometry
    
    var id : String { self.rawValue }
    
    var sideBarString : String {
        switch self {
        case .basics: return "Basics"
        case .transitions: return "Transitions"
        case .scrollTransitions: return "ScrollView Transitions"
        case .matchedGeometry: return "Matched Geometry Effect"
        }
    }
    
    @ViewBuilder
    var detailView : some View {
        switch self {
        case .basics:
            BasicsView()
        case .transitions:
            TransitionsView()
        case .scrollTransitions:
            ScrollTransitionsView()
        case .matchedGeometry:
            MatchedGeometryView()
        }
    }
}
