//
//  CounterView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct CounterView: View {
    
    @ObservedObject var gameManagerVM: GameManagerViewModel
    private let minSize = 32
    private let maxSize = 256
    
    var body: some View {
        Text(String(gameManagerVM.correctCount))
            .foregroundStyle(.white)
            .font(.system(size: counterSize()))
            .fontWeight(.bold)
    }
    
    private func counterSize() -> CGFloat {
        return CGFloat(minSize + (((maxSize - minSize) / gameManagerVM.fruitsOrder.count) * gameManagerVM.correctCount))
    }
}

#Preview {
    CounterView(gameManagerVM: GameManagerViewModel())
}
