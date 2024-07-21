//
//  AppNavigationView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct AppNavigationView: View {
    @State private var selectedAppScreen : AppScreen? = .basics
    
    var body: some View {
        NavigationSplitView {
            SideBarView(selectedAppScreen: $selectedAppScreen)
                .frame(minWidth: 280)
        } detail: {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(AppScreen.allCases) { appScreen in
                        appScreen.detailView
                            .frame(maxHeight: .infinity)
                            .containerRelativeFrame(.vertical)
                            .id(appScreen)
                    }
                    .scrollTargetLayout()
                }
            }
            .scrollPosition(id: $selectedAppScreen)
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .scrollDisabled(true)
            .clipped()
        }
    }
}

#Preview {
    AppNavigationView()
}
