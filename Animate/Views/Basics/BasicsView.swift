//
//  BasicsView.swift
//  Animate
//
//  Created by Greg Ross on 19/07/2024.
//

import SwiftUI

struct BasicsView: View {
    @State private var showGreen : Bool = true
    @State private var showPink : Bool = true
    @State private var showBlue : Bool = true
    @State private var showOrange : Bool = true
    @State private var showYellow : Bool = true
    @State private var animationDuration : CGFloat = 1.2
    
    var body: some View {
        VStack(spacing: 100) {
            HStack(spacing: 20) {
                section(color: .green,
                        animationTitle: "Linear",
                        animation: .linear(duration: animationDuration),
                        show: $showGreen)
                
                section(color: .pink,
                        animationTitle: "Ease In/Out",
                        animation: .easeInOut(duration: animationDuration),
                        show: $showPink)
                
                section(color: .blue,
                        animationTitle: "Snappy",
                        animation: .snappy(duration: animationDuration),
                        show: $showBlue)
                
                section(color: .orange,
                        animationTitle: "Bouncy",
                        animation: .bouncy(duration: animationDuration),
                        show: $showOrange)
                
                section(color: .yellow,
                        animationTitle: "Spring",
                        animation: .spring(duration: animationDuration),
                        show: $showYellow)
            }
            
            VStack {
                Text("Animation Duration: \(animationDuration.formatted())")
                Slider(value: $animationDuration, in: 0.2...2, step: 0.2)
                    .frame(width: 300)
            }
            
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 24)
    }
}

private extension BasicsView {
    func section(color : Color,
                 animationTitle : String,
                 animation : Animation,
                 show : Binding<Bool>) -> some View {
        VStack(spacing: 16) {
            ZStack {
                color
                    .frame(width: 200, height: 200)
                    .clipShape(.rect(cornerRadius: 12))
                
                Text(animationTitle)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .frame(width: 200, height: 200)
            .scaleEffect(show.wrappedValue ? 1 : 0)
            .rotationEffect(Angle(degrees: show.wrappedValue ? 0 : 270))
            
            Button {
                withAnimation(animation) {
                    show.wrappedValue.toggle()
                }
            } label: {
                Text(show.wrappedValue ? "Hide" : "Show")
                    .font(.headline)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(.clear)
                    .clipShape(.rect(cornerRadius: 8))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(color)
                    }
                    .contentShape(.rect(cornerRadius: 8))
            }
            .buttonStyle(PlainScalingButtonStyle())
        }
    }
}

#Preview {
    BasicsView()
}
