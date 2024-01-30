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
        tutorialMessage()
            .font(.title)
            .fontWeight(.light)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
    }
    
    private func tutorialMessage() -> Text {
        if !gameVM.swappedFruits {
            return Text("swap-tutorial-string")
        } else if gameVM.level == 1 {
            return Text("level1-tutorial-string")
        } else if gameVM.level == 5 {
            return Text("level5-tutorial-string")
        } else if gameVM.level == 40 {
            return Text("level40-tutorial-string")
        } else if gameVM.level == 70 {
            return Text("level70-tutorial-string")
        } else if gameVM.level == 100 {
            return Text("level100-tutorial-string")
        }
        return  Text("")
    }
}

#Preview {
    TutorialView(gameVM: GameViewModel())
}
