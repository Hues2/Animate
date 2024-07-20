//
//  AppNavigationView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var selectedAppScreen : AppScreen = .keyFrames
    
    var body: some View {
        NavigationSplitView {
            SideBarView(selectedAppScreen: $selectedAppScreen)
        } detail: {
            selectedAppScreen.detailView
        }
    }
}

#Preview {
    AppNavigationView()
}
