//
//  TutorialView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct TutorialView: View {
    
    @ObservedObject var gameVM: GameViewModel
    
    var body: some View {
        Text(tutorialMessage())
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
    }
    
    private func tutorialMessage() -> String {
        if !gameVM.swappedFruits {
            return "Tap the fruits to swap them."
        } else if gameVM.level == 1 {
            return "Try to guess the order of the Fruits"
        } else if gameVM.level == 5 {
            return "The amount of fruits increases as you progress to higher levels."
        }
        return  ""
    }
}

#Preview {
    TutorialView(gameVM: GameViewModel())
}
