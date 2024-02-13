//
//  FruitView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct FruitView: View {
    
    @ObservedObject var gameManagerVM: GameManagerViewModel
    
    var body: some View {
        HStack {
            ForEach(gameManagerVM.fruitsOrder, id: \.self) { fruit in
                Text(fruit.emoji)
                    .font(.system(size: fruitSize()))
                    .padding(.bottom, gameManagerVM.selectedFruit == fruit ? 40 : 0)
                    .onTapGesture {
                        manageTouchGesture(fruit: fruit)
                    }
                    .animation(.easeInOut)
            }
        }
    }
    
    private func manageTouchGesture(fruit: Fruit) {
        if gameManagerVM.selectedFruit == nil {
            hapticFeedback()
            gameManagerVM.selectedFruit = fruit
        } else if gameManagerVM.selectedFruit == fruit {
            hapticFeedback()
            gameManagerVM.selectedFruit = nil
        } else {
            hapticFeedback(style: .heavy)
            prepareToSwapElements(fruit: fruit)
        }
    }
    
    private func prepareToSwapElements(fruit: Fruit) {
        if let selectedIndex = gameManagerVM.fruitsOrder.firstIndex(of: gameManagerVM.selectedFruit!),
           let tappedIndex = gameManagerVM.fruitsOrder.firstIndex(of: fruit) {
            gameManagerVM.swapElements(index1: selectedIndex, index2: tappedIndex)
        }
        gameManagerVM.selectedFruit = nil
    }
    
    private func fruitSize() -> CGFloat {
        switch gameManagerVM.level {
        case 1 ..< 5:
            return 64
        case 5 ..< 40:
            return 56
        case 40 ..< 70:
            return 48
        case 70 ..< 100:
            return 40
        default:
            return 40
        }
    }
}

#Preview {
    FruitView(gameManagerVM: GameManagerViewModel())
}
