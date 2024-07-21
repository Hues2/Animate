//
//  SideBarView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct SideBarView: View {
    @Binding var selectedAppScreen : AppScreen?
    @Namespace private var namespace
    
    var body: some View {
        list
    }
}

// MARK: List
private extension SideBarView {
    var list : some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 2) {
                ForEach(AppScreen.allCases) { appScreen in
                    row(appScreen)
                        .padding(.vertical, 12)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.smooth) {
                                self.selectedAppScreen = appScreen
                            }
                        }                    
                }
            }
            .padding(.horizontal, 8)
        }
        .scrollIndicators(.hidden)
    }
    
    func row(_ appScreen : AppScreen) -> some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                    .fill(.clear)
                    .frame(width: 14, height: 3)
                    .rotationEffect(Angle(degrees: 90))
                
                if appScreen == selectedAppScreen {
                    RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                        .fill(.pink)
                        .frame(width: 14, height: 3)
                        .rotationEffect(Angle(degrees: 90))
                        .matchedGeometryEffect(id: "checkmark", in: namespace)
                }
            }
            
            Text(appScreen.sideBarString)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(appScreen == selectedAppScreen ? .pink : .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .animation(.smooth, value: selectedAppScreen)
    }
}

#Preview {
    AppNavigationView()
}
