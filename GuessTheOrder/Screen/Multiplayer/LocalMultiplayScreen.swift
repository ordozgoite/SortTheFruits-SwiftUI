//
//  MultiplayerGameScreen.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 08/03/24.
//

import SwiftUI
import AudioToolbox
import AVFoundation

struct LocalMultiplayScreen: View {
    
    private let audioManager = AudioManager()
    @ObservedObject private var gameManagerVM = GameManagerViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Background(level: .constant(1))
                
                Header()
                
                VStack {
                    ZStack {
                        VStack {
                            CounterView(correctCount: $gameManagerVM.correctCount, fruitsQuantity: gameManagerVM.fruitsOrder.count)
                            Spacer()
                        }
                        Fruits()
                    }
                    .rotationEffect(.degrees(180))
                    
                    Divider()
                    
                    ZStack {
                        VStack {
                            CounterView(correctCount: $gameManagerVM.correctCount, fruitsQuantity: gameManagerVM.fruitsOrder.count)cc
                            Spacer()
                        }
                        Fruits()
                    }
                }
                
                Settings()
            }
        }
        .onChange(of: gameManagerVM.fruitsOrder) { _ in
            if gameManagerVM.correctCount == gameManagerVM.fruitsOrder.count {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//                gameVM.goToNextLevel()
            }
        }
    }
    
    //MARK: - Header
    
    @ViewBuilder
    private func Header() -> some View {
        VStack {
            ZStack(alignment: .top) {
                HStack {
                    
                    Spacer()
                    
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            hapticFeedback()
//                            gameVM.isSettingsViewDisplayed.toggle()
                        }
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    //MARK: - Fruits
    
    @ViewBuilder
    private func Fruits() -> some View {
        VStack {
            Spacer()
            
            FruitView(gameManagerVM: gameManagerVM)
            
            Spacer()
        }
    }
    
    //MARK: - Settings View
    
    @ViewBuilder
    private func Settings() -> some View {
//        if gameVM.isSettingsViewDisplayed {
//            SettingsView(gameVM: gameVM)
//        }
    }
}

#Preview {
    LocalMultiplayScreen()
}
