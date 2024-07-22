//
//  ScrollTransitionsView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

private extension ScrollTransitionsView {
    enum ScrollType : String, CaseIterable, CustomPickerOption {
        case horizontal, vertical
        
        var id : String { self.rawValue }
        
        var title : String {
            switch self {
            case .horizontal:
                "Horizontal"
            case .vertical:
                "Vertical"
            }
        }
        
        var pickerId : String { "scrollType" }
    }
}

struct ScrollTransitionsView: View {
    @Namespace private var namespace
    @State private var scrollType : ScrollType = .horizontal
    private let colors : [Color] = [.green, .pink, .blue, .orange, .yellow, .red,
                                    .purple, .cyan, .indigo, .mint, .black, .green,
                                    .pink, .blue, .orange, .yellow, .red, .purple]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                if scrollType == .horizontal {
                    HorizontalScrollTransition(colors: colors)
                } else {
                    VerticalScrollTransition(colors: colors)
                }
            }
            CustomPicker(namespace: namespace, selectedOption: $scrollType, options: ScrollType.allCases)
        }
    }
}

#Preview {
    ScrollTransitionsView()
}
