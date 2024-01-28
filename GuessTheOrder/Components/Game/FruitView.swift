//
//  FruitView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct FruitView: View {
    
    @ObservedObject var gameVM: GameViewModel
    
    var body: some View {
        HStack {
            ForEach(gameVM.fruitsOrder, id: \.self) { fruit in
                //                Image(fruit.name)
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                //                    .frame(width: screenWidth / CGFloat(gameVM.fruitsOrder.count + 2), height: screenWidth / CGFloat(gameVM.fruitsOrder.count + 2))
                //                    .padding(.bottom, gameVM.selectedFruit == fruit ? 32 : 0)
                //                    .onTapGesture {
                //                        manageTouchGesture(fruit: fruit)
                //                    }
                Text(fruit.emoji)
                    .font(.system(size: fruitSize()))
                    .padding(.bottom, gameVM.selectedFruit == fruit ? 32 : 0)
                    .onTapGesture {
                        manageTouchGesture(fruit: fruit)
                    }
            }
        }
    }
    
    private func manageTouchGesture(fruit: Fruit) {
        if gameVM.selectedFruit == nil {
            hapticFeedback()
            gameVM.selectedFruit = fruit
        } else if gameVM.selectedFruit == fruit {
            hapticFeedback()
            gameVM.selectedFruit = nil
        } else {
            hapticFeedback(style: .heavy)
            prepareToSwapElements(fruit: fruit)
        }
    }
    
    private func prepareToSwapElements(fruit: Fruit) {
        if let selectedIndex = gameVM.fruitsOrder.firstIndex(of: gameVM.selectedFruit!),
           let tappedIndex = gameVM.fruitsOrder.firstIndex(of: fruit) {
            gameVM.swapElements(index1: selectedIndex, index2: tappedIndex)
        }
        gameVM.selectedFruit = nil
    }
    
    private func fruitSize() -> CGFloat {
        switch gameVM.level {
        case 1 ..< 5:
            return 64
        case 5 ..< 40:
            return 56
        case 40 ..< 70:
            return 48
        case 70 ..< 100:
            return 40
        default:
            return 32
        }
    }
}

#Preview {
    FruitView(gameVM: GameViewModel())
}
