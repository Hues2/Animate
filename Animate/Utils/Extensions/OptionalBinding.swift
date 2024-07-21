//
//  OptionalBinding.swift
//  Animate
//
//  Created by Greg Ross on 21/07/2024.
//

import SwiftUI

extension Binding {
    var optional: Binding<Value?> {
        return Binding<Value?>(
            get: { self.wrappedValue },
            set: { newValue in
                if let newValue = newValue {
                    self.wrappedValue = newValue
                }
            }
        )
    }
}
