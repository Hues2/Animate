//
//  AppScreen.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import Foundation

enum AppScreen : String, Identifiable, Hashable, CaseIterable {
    case basics
    case scrollTransitions
    case matchedGeometry
    
    var id : String { self.rawValue }
    
    var sideBarString : String {
        switch self {
        case .basics: return "Basics"
        case .scrollTransitions: return "ScrollView Transitions"
        case .matchedGeometry: return "Matched Geometry Effect"
        }
    }
}
