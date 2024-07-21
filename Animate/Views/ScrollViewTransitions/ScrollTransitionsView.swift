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
    private let colors : [Color] = [.green, .pink, .blue, .orange, .yellow, .red, .purple, .cyan, .indigo, .mint,
                                    .white, .black, .green, .pink, .blue, .orange, .yellow, .red, .purple]
    
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
        HStack(spacing: 16) {
            pickerSegment(.horizontal)
            pickerSegment(.vertical)
            
        }
        .font(.title3)
        .fontWeight(.semibold)
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .stroke(Color.pink)
                .compositingGroup()
                .shadow(color: .black, radius: 4)
        }
        .padding()
    }
    
    func pickerSegment(_ scrollType : ScrollType) -> some View {
        Text(scrollType == .horizontal ? "Horizontal" : "Vertical")
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.smooth) {
                    self.scrollType = scrollType
                }
            }
            .padding(8)
            .overlay(alignment: .bottom) {
                if self.scrollType == scrollType {
                    RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                        .fill(.gray)
                        .frame(width: 44, height: 2)
                        .matchedGeometryEffect(id: "selection", in: namespace)
                }
            }
    }
}

#Preview {
    ScrollTransitionsView()
}
