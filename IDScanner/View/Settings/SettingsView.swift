//
//  SettingsView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 18.10.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 36, height: 5)
                .foregroundStyle(blueText)
                .opacity(0.15)
                .padding(.top, 5)
            VStack(spacing: 16) {
                ZStack {
                    Text("Settings")
                        .font(.headline)
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Close")
                                .font(.headline)
                                .foregroundStyle(blueButton)
                        })
                        .padding(.trailing, 16)
                    }
                }
                .frame(height: 44)
                VStack (spacing: 10) {
                    
                    bigButton
                    
                    SettingsLittleButton(buttonText: "Terms Of Use")
                    
                    SettingsLittleButton(buttonText: "Privacy Policy")
                    
                    SettingsLittleButton(buttonText: "Restore Purchases")
                    
                    SettingsLittleButton(buttonText: "Contact Us")
                    
                    SettingsLittleButton(buttonText: "Share app")
                }
                Spacer()
            }
        }
    }
    
    var bigButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 230)
                .opacity(0.1)
            VStack(spacing: 16) {
                VStack(spacing: 10) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 37.93))
                    
                    Text("Get Premium Access")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
                .padding(.top, 32)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 68)
                    Text("Upgrade to premium")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 16)
            }
        }
        .foregroundStyle(blueButton)
        .padding(.horizontal, 16)
    }
}

struct SettingsLittleButton: View {
    
    @State var buttonText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 68)
                .opacity(0.1)
            HStack {
                Text(buttonText)
                    .font(.callout)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 17.88))
            }
            .padding(.horizontal, 16)
        }
        .foregroundStyle(blueButton)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SettingsView()
}
