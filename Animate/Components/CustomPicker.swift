//
//  CustomPicker.swift
//  Animate
//
//  Created by Greg Ross on 22/07/2024.
//

import SwiftUI

protocol CustomPickerOption : Identifiable, Equatable, CaseIterable {
    var id : String { get }
    var title : String { get }
}

struct CustomPicker<T : CustomPickerOption>: View {
    @Namespace private var namespace
    @Binding var selectedOption : T
    let options : [T]
    private let id = "matched_geometry_effect_id"
    
    var body: some View {
        picker
    }
}

private extension CustomPicker {
    var picker : some View {
        HStack(spacing: 16) {
            ForEach(options) { option in
                pickerSegment(option)
            }
        }
        .font(.title3)
        .fontWeight(.semibold)
        .padding(16)
        .overlay {
            RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                .stroke(Color.pink)
                .compositingGroup()
                .shadow(color: .black, radius: 4)
        }
        .padding(24)
    }
    
    func pickerSegment(_ option : T) -> some View {
        Text(option.title)
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.smooth) {
                    self.selectedOption = option
                }
            }
            .padding(8)
            .overlay(alignment: .bottom) {
                if self.selectedOption == option {
                    RoundedRectangle(cornerRadius: Constants.UI.pillShapeCornerRadius)
                        .fill(.gray)
                        .frame(width: 44, height: 2)
                        .matchedGeometryEffect(id: id, in: namespace)
                }
            }
    }
}
