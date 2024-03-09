//
//  CounterView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct CounterView: View {
    
    private let minSize = 32
    private let maxSize = 256
    
    @Binding var correctCount: Int
    let fruitsQuantity: Int
    
    var body: some View {
        VStack {
            Text("correct-string")
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            
            Text(String(correctCount))
                .foregroundStyle(.white)
                .font(.system(size: counterSize()))
                .fontWeight(.bold)
        }
    }
    
    private func counterSize() -> CGFloat {
        return CGFloat(minSize + (((maxSize - minSize) / fruitsQuantity) * correctCount))
    }
}

#Preview {
    CounterView(correctCount: .constant(0), fruitsQuantity: 5)
}
