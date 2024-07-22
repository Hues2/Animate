//
//  MatchedGeometryView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

private extension MatchedGeometryView {
    enum AnimationOption : String, CustomPickerOption {
        case withoutAnimation, withAnimation
        
        var id : String { self.rawValue }
        
        var title : String {
            switch self {
            case .withoutAnimation:
                "Without Animation"
            case .withAnimation:
                "With Animation"
            }
        }
    }
    
    struct CustomColor : Identifiable, Equatable {
        var id : String { self.color.description }
        let color : Color
    }
}

struct MatchedGeometryView: View {
    @Namespace private var namespace
    @State private var selectedColors : [CustomColor] = []
    @State private var allColors : [CustomColor] = Constants.UI.colors.map({ CustomColor(color: $0) })
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State private var animationOption : AnimationOption = .withoutAnimation
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 40) {
                selectedColorsView
                allColorsView
            }
            .frame(maxHeight: .infinity)
            .padding(.vertical, 24)
            
            CustomPicker(selectedOption: $animationOption, options: AnimationOption.allCases)
        }
    }
}

private extension MatchedGeometryView {
    var selectedColorsView : some View {
        VStack {
            Text("Selected Colors:")
                .font(.title)
                .fontWeight(.ultraLight)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
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
                            // This fixes an issue if the card is double tapped quickly
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
    
    func card(_ customColor : CustomColor, _ size : CGFloat, _ action : @escaping () -> Void) -> some View {
        customColor.color
            .frame(width: size, height: size)
            .clipShape(.rect(cornerRadius: Constants.UI.pillShapeCornerRadius))
            .cornerRadius(10)
            .matchedGeometryEffect(id: customColor.id, in: namespace)
            .onTapGesture {
                withAnimation(animationOption == .withoutAnimation ? .none : .snappy) {
                    action()
                }
            }
            .zIndex(5)
    }
}

#Preview {
    MatchedGeometryView()
}
