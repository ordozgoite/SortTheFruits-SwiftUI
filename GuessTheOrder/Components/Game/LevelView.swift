//
//  LevelView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct LevelView: View {
    
    @ObservedObject var gameVM: GameViewModel
    
    var body: some View {
        Text("level-string \(String(gameVM.level))")
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.medium)
    }
}

#Preview {
    LevelView(gameVM: GameViewModel())
}
