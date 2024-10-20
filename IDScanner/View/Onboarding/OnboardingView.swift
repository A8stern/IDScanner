//
//  OnboardingView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 20.10.2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboardingSeen") var onboardingState: Bool = false
    @State private var onboardingCount: Int = 0
    
    var body: some View {
        ZStack {
            white.ignoresSafeArea()
            
            VStack {
                topIndicators
                
                Spacer()
            }
            
            slides
            
            VStack {
                Spacer()
                
                bottomPart
            }
        }
        .animation(.easeInOut(duration: 0.3), value: onboardingCount)
    }
    
    var topIndicators: some View {
        ZStack {
            HStack {
                Button(action: {onboardingCount -= 1}, label: {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .opacity(0.1)
                            .font(.system(size: 40))
                        Image(systemName: "chevron.left")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(blueButton)
                    .padding(.leading, 16)
                })
                .opacity(onboardingCount == 0 ? 0 : 1)
                Spacer()
            }
            
            HStack {
                Spacer()
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 150, height: 8)
                        .foregroundStyle(greyIndicator)
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 50 + CGFloat((50 * onboardingCount)), height: 8)
                        .foregroundStyle(blueButton)
                }
                Spacer()
            }
        }
    }
    
    var slides: some View {
        ZStack {
            ZStack {
                ZStack {
                    HStack {
                        Image("idPhoto")
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("handIphone")
                        }
                    }
                }
                VStack {
                    Spacer()
                    textUnderImage(textUp: "Scan in Seconds", textDown: "Quick ID scanning with no delays")
                }
            }
            .opacity(onboardingCount == 0 ? 1 : 0)
            
            ZStack {
                Image("archeryQR")
                    .padding(.leading, 59)
                    .padding(.bottom, 130)
                VStack {
                    Spacer()
                    textUnderImage(textUp: "Precision Guaranteed", textDown: "AI-powered, flawless recognition every time")
                }
            }
            .opacity(onboardingCount == 1 ? 1 : 0)
            
            ZStack {
                Image("lockPassword")
                    .padding(.bottom, 110)
                VStack {
                    Spacer()
                    textUnderImage(textUp: "Total Privacy", textDown: "Your security is our priority")
                }
            }
            .opacity(onboardingCount == 2 ? 1 : 0)
        }
    }
    
    func textUnderImage(textUp: String, textDown: String) -> some View {
        return VStack {
            Text(textUp)
                .foregroundStyle(blueText)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(textDown)
                .foregroundStyle(greyTextOnboarding)
                .font(.callout)
        }
        .padding(.bottom, 150)
    }
    
    var bottomPart: some View {
        VStack(spacing: 16) {
            Button {
                buttonTapped()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 68)
                    .padding(.horizontal, 16)
                    .foregroundStyle(blueButton)
                    .overlay {
                        Text("Continue")
                            .foregroundStyle(white)
                            .font(.callout)
                            .fontWeight(.bold)
                    }
            }
            
            HStack(alignment: .center) {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Terms of Use")
                        .font(.caption)
                })
                Image(systemName: "circle.fill")
                    .font(.system(size: 2))
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Privacy Policy")
                        .font(.caption)
                })
                Spacer()
            }
            .foregroundStyle(blueText)
            .opacity(0.5)
        }
        .padding(.bottom, 16)
    }
    
    func buttonTapped() {
        if onboardingCount == 2 {
            onboardingState = true
        } else {
            onboardingCount += 1
        }
    }
}

#Preview {
    OnboardingView()
}
