//
//  TransitionsView.swift
//  Animate
//
//  Created by Greg Ross on 20/07/2024.
//

import SwiftUI

struct TransitionsView: View {
    @State private var showGreen : Bool = true
    @State private var showPink : Bool = true
    @State private var showBlue : Bool = true
    @State private var showOrange : Bool = true
    @State private var showIndigo : Bool = true
    @State private var showPurple : Bool = true
    @State private var animationType : AnimationType = .easeInOut
    @State private var animationDuration : CGFloat = 1.2
    
    var body: some View {
        VStack(spacing: 80) {
            HStack {
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
                
                section(color: .indigo,
                        transitionTitle: "Asymetric - Scale, Move",
                        transition: .asymmetric(insertion: .scale, removal: .move(edge: .trailing)),
                        show: $showIndigo)
                
                section(color: .purple,
                        transitionTitle: "Combination - Opacity, Scale, Offset",
                        transition: .opacity.combined(with: .scale).combined(with: .offset(x: 100, y: -100)),
                        show: $showPurple)
            }
            .frame(maxHeight: .infinity)
            
            Divider()
            
            AnimationControllerView(animationType: $animationType.optional,
                                    animationDuration: $animationDuration)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 80)
    }
}

private extension TransitionsView {
    var controls : some View {
        VStack(spacing: 40) {
            VStack {
                Text("Animation:")
                    .font(.title2)
                    .fontWeight(.ultraLight)
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
                    .font(.title2)
                    .fontWeight(.ultraLight)
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
                            .frame(width: 200, height: 200)
                            .clipShape(.rect(cornerRadius: Constants.UI.cornerRadius))
                        
                        Text(transitionTitle)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(2)
                    }
                    .transition(transition)
                }
            }
            .frame(width: 200, height: 200)
            
            Button {
                withAnimation(animationType.animation(withDuration: animationDuration)) {
                    show.wrappedValue.toggle()
                }
            } label: {
                Text(show.wrappedValue ? "Hide" : "Show")
                    .font(.title3)
                    .padding(12)
                    .frame(width: 200)
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
    TransitionsView()
}
