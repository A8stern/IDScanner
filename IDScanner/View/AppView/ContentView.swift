//
//  ContentView.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 18.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboardingSeen") var onboardingState: Bool = false
    
    var body: some View {
        if !onboardingState {
            OnboardingView()
        } else {
            CameraScanner()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
