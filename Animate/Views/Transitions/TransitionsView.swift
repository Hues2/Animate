//
//  TransitionsView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct TransitionsView: View {
    enum AnimationType : String, Identifiable, CaseIterable {
        case easeInOut, smooth, snappy, bouncy
        
        var id : String { self.rawValue }
        
        var displayString : String {
            switch self {
            case .easeInOut: return "Ease In/Out"
            case .smooth: return "Smooth"
            case .snappy: return "Snappy"
            case .bouncy: return "Bouncy"
            }
        }
        
        func animation(withDuration duration: Double) -> Animation {
            switch self {
            case .easeInOut: return .easeInOut(duration: duration)
            case .smooth: return .linear(duration: duration)
            case .snappy: return .interactiveSpring(response: duration, dampingFraction: 0.5, blendDuration: 0.5)
            case .bouncy: return .spring(response: duration, dampingFraction: 0.5, blendDuration: 0.5)
            }
        }
    }
    
    @State private var showGreen : Bool = true
    @State private var showPink : Bool = true
    @State private var showBlue : Bool = true
    @State private var showOrange : Bool = true
    @State private var showYellow : Bool = true
    @State private var showPurple : Bool = true
    @State private var animationType : AnimationType = .easeInOut
    @State private var animationDuration : CGFloat = 1.2
    
    var body: some View {
        VStack(spacing: 80) {
            HStack(spacing: 32) {
                section(color: .green,
                        transitionTitle: "Opacity",
                        transition: .opacity,
                        show: $showGreen)
                
                section(color: .pink,
                        transitionTitle: "Scale",
                        transition: .scale,
                        show: $showPink)
                
                section(color: .blue,
                        transitionTitle: "Move - Top Edge",
                        transition: .move(edge: .top),
                        show: $showBlue)
                                
                section(color: .orange,
                        transitionTitle: "Push - Bottom Edge",
                        transition: .push(from: .bottom),
                        show: $showOrange)
                
                section(color: .yellow,
                        transitionTitle: "Asymetric - Scale, Opacity",
                        transition: .asymmetric(insertion: .scale, removal: .opacity),
                        show: $showYellow)
                
                section(color: .purple,
                        transitionTitle: "Combination - Opacity, Scale, Offset",
                        transition: .opacity.combined(with: .scale).combined(with: .offset(x: 100, y: -100)),
                        show: $showPurple)
            }
            
            VStack(spacing: 40) {
                VStack {
                    Text("Animation:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    MenuButton(animationType.displayString) {
                        ForEach(AnimationType.allCases) { animationType in
                            Button {
                                withAnimation {
                                    self.animationType = animationType
                                }
                            } label: {
                                Text(animationType.displayString)
                            }
                        }
                    }
                }
                
                VStack {
                    Text("Animation Duration: \(String(format: "%.1f", animationDuration))s")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentTransition(.numericText())
                        .animation(.smooth, value: animationDuration)
                    Slider(value: $animationDuration, in: 0.2...2, step: 0.2)                        
                }
            }
            .frame(width: 300)
            .padding(32)
            .overlay {
                RoundedRectangle(cornerRadius: Constants.UI.cornerRadius)
                    .stroke(.pink)
                    .shadow(color: .black, radius: 4)
            }
            
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 24)
    }
}

private extension TransitionsView {
    func section(color : Color,
                 transitionTitle : String,
                 transition : AnyTransition,
                 show : Binding<Bool>) -> some View {
        VStack(spacing: 16) {
            VStack {
                if show.wrappedValue {
                    ZStack {
                        color
                            .frame(width: 240, height: 240)
                            .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                        
                        Text(transitionTitle)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .transition(transition)
                }
            }
            .frame(width: 250, height: 250)
            
            Button {
                withAnimation(animationType.animation(withDuration: animationDuration)) {
                    show.wrappedValue.toggle()
                }
            } label: {
                Text(show.wrappedValue ? "Hide" : "Show")
                    .font(.title3)
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
    }
}

#Preview {
    TransitionsView()
}
