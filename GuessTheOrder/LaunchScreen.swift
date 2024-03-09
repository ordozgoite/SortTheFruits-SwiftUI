//
//  LaunchScreen.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var hasGameStarted: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.0
    
    var body: some View {
        if hasGameStarted {
            SinglePlayScreen()
        } else {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("ORDOZ")
                        .font(Font.custom("OctopusGame", size: 80))
                        .foregroundStyle(.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                    hasGameStarted = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
