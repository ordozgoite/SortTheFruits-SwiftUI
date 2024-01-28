//
//  CounterView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct CounterView: View {
    
    @ObservedObject var gameVM: GameViewModel
    private let minSize = 32
    private let maxSize = 256
    
    var body: some View {
        Text(String(gameVM.correctCount))
            .foregroundStyle(.white)
            .font(.system(size: counterSize()))
            .fontWeight(.bold)
    }
    
    private func counterSize() -> CGFloat {
        return CGFloat(minSize + (((maxSize - minSize) / gameVM.fruitsOrder.count) * gameVM.correctCount))
    }
}

#Preview {
    CounterView(gameVM: GameViewModel())
}
