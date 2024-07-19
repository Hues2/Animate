//
//  AppNavigationView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var selectedAppScreen : AppScreen = .basics
    
    var body: some View {
        NavigationSplitView {
            SideBarView(selectedAppScreen: $selectedAppScreen)
        } detail: {
            switch selectedAppScreen {
            case .basics:
                BasicsView()
            case .scrollTransitions:
                Text("Scroll transitions")
            case .matchedGeometry:
                Text("Matched Geometry")
            }
        }
    }
}

#Preview {
    AppNavigationView()
}
