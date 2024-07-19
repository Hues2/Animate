//
//  MatchedGeometryView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct MatchedGeometryView: View {
    struct CustomColor : Identifiable, Equatable {
        let id = UUID().uuidString
        let color : Color
    }
    @Namespace private var namespace
    @State private var selectedColors : [CustomColor] = []
    @State private var allColors : [CustomColor] = Constants.UI.colors.map({ CustomColor(color: $0) })
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 40) {
            selectedColorsView
            allColorsView
        }
        .padding(.vertical, 24)
    }
}

private extension MatchedGeometryView {
    var selectedColorsView : some View {
        VStack {
            Text("Selected Colors:")
                .font(.title)
                .fontWeight(.ultraLight)
                .frame(maxWidth: .infinity, alignment: .leading)
                        
                HStack {
                    ForEach(selectedColors) { color in
                        card(color, 100) {
                            self.selectedColors.removeAll(where: { $0 == color })
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 120)
        }
        .padding(24)
    }
    
    var allColorsView : some View {
        VStack(spacing: 24) {
            Text("All Colors:")
                .font(.title)
                .fontWeight(.ultraLight)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(allColors) { color in
                    if !selectedColors.contains(color) {
                        card(color, 100) {
                            self.selectedColors.removeAll(where: { $0 == color })
                            self.selectedColors.append(color)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(24)
    }
    
    func card(_ color : CustomColor, _ size : CGFloat, _ action : @escaping () -> Void) -> some View {
        color.color
            .frame(width: size, height: size)
            .clipShape(.rect(cornerRadius: Constants.UI.pillShapeCornerRadius))
            .cornerRadius(10)
            .matchedGeometryEffect(id: color.id, in: namespace)
            .onTapGesture {
                withAnimation(.smooth) {
                    action()
                }
            }
            .zIndex(5)
    }
}

#Preview {
    MatchedGeometryView()
}
