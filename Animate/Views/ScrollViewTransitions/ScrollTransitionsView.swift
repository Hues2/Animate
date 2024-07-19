//
//  ScrollTransitionsView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

private extension ScrollTransitionsView {
    enum ScrollType {
        case horizontal, vertical
    }
}

struct ScrollTransitionsView: View {
    @Namespace private var namespace
    @State private var scrollType : ScrollType = .horizontal
    private let colors : [Color] = [.green, .pink, .blue, .orange, .yellow, .red, .purple, .cyan, .indigo, .mint, .white, .black, .green, .pink, .blue, .orange, .yellow, .red, .purple]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                if scrollType == .horizontal {
                    HorizontalScrollTransition(colors: colors)
                } else {
                    VerticalScrollTransition(colors: colors)
                }
            }
            picker
        }
    }
}

private extension ScrollTransitionsView {
    var picker : some View {
        HStack(spacing: 24) {
            Text("Horizontal")
                .onTapGesture {
                    withAnimation(.smooth) {
                        self.scrollType = .horizontal
                    }
                }
                .padding(8)
                .overlay(alignment: .bottom) {
                    if scrollType == .horizontal {
                        RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                            .fill(.pink)
                            .frame(width: 44, height: 2)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
            
            Text("Vertical")
                .onTapGesture {
                    withAnimation(.smooth) {
                        self.scrollType = .vertical
                    }
                }
                .padding(8)
                .overlay(alignment: .bottom) {
                    if scrollType == .vertical {
                        RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                            .fill(.pink)
                            .frame(width: 44, height: 2)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
        }
        .font(.title3)
        .fontWeight(.semibold)
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .stroke(Color.gray)
                .compositingGroup()
                .shadow(color: .black.opacity(0.5), radius: 4)
        }
        .padding()
    }
}

#Preview {
    ScrollTransitionsView()
}
