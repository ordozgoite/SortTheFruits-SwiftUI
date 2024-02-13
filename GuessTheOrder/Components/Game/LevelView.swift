//
//  LevelView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct LevelView: View {
    
    @ObservedObject var gameManagerVM: GameManagerViewModel
    
    var body: some View {
        Text("level-string \(String(gameManagerVM.level))")
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.medium)
    }
}

#Preview {
    LevelView(gameManagerVM: GameManagerViewModel())
}
