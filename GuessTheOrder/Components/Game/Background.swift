//
//  Background.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import SwiftUI

struct Background: View {
    
    @ObservedObject var gameVM: GameViewModel

    var body: some View {
        let gradientColors = gradientColorsForLevel(gameVM.level)

        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }

    private func gradientColorsForLevel(_ level: Int) -> [Color] {
        let hue = Double(level % 100) / 100.0
        return [Color(hue: hue, saturation: 0.8, brightness: 0.8), Color(hue: hue + 0.2, saturation: 0.8, brightness: 0.8)]
    }
}

#Preview {
    Background(gameVM: GameViewModel())
}
