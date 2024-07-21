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
    @State private var showIndigo : Bool = true
    @State private var animationDuration : CGFloat = 1.2
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
                section(color: .green,
                        animationTitle: "Linear",
                        animation: .linear(duration: animationDuration),
                        show: $showGreen)
                
                section(color: .pink,
                        animationTitle: "Ease In/Out",
                        animation: .easeInOut(duration: animationDuration),
                        show: $showPink)
                
                // Snappy is fast and has a slight bounce (extra bounce can be added)
                section(color: .blue,
                        animationTitle: "Snappy",
                        animation: .snappy(duration: animationDuration),
                        show: $showBlue)
                
                // Bouncy is like a pre-defined spring
                section(color: .orange,
                        animationTitle: "Bouncy",
                        animation: .bouncy(duration: animationDuration),
                        show: $showOrange)
                
                section(color: .indigo,
                        animationTitle: "Spring",
                        // Response --> How stiff the spring is. The lower the value, the faster the bounces
                        // Damping Fraction --> How much the animation should resist bouncing back and forth. Lower the value, the more it bounces back and forth
                        animation: .spring(response: animationDuration, dampingFraction: 0.5),
                        show: $showIndigo)
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 24)
            
            Divider()
            
            AnimationControllerView(animationType: .constant(nil),
                                    animationDuration: $animationDuration)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.vertical, 80)
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
                    .frame(width: 240, height: 240)
                    .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                
                Text(animationTitle)
                    .font(.title)
                    .fontWeight(.ultraLight)
            }
            .frame(width: 250, height: 250)
            .scaleEffect(show.wrappedValue ? 1 : 0)
            .rotationEffect(Angle(degrees: show.wrappedValue ? 0 : 270))
            
            Button {
                withAnimation(animation) {
                    show.wrappedValue.toggle()
                }
            } label: {
                Text(show.wrappedValue ? "Hide" : "Show")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .padding(12)
                    .frame(width: 250)
                    .background(.clear)
                    .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                    .overlay {
                        RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                            .stroke(color)
                    }
                    .contentShape(.rect(cornerRadius: Constants.UI.cornerRadius))
            }
            .buttonStyle(PlainScalingButtonStyle())
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BasicsView()
}
