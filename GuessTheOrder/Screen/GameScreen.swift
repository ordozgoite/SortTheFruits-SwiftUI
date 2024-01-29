//
//  GameScreen.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import SwiftUI
import AudioToolbox
import AVFoundation

struct GameScreen: View {
    
    @ObservedObject private var gameVM = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Background(gameVM: gameVM)
                
                Header()
                
                Fruits()
                
                TutorialText()
                
                SuccessAnimation(geometry: geometry)
                
                Settings()
                
                InterstitialAd()
            }
        }
        .onChange(of: gameVM.fruitsOrder) { _ in
            if gameVM.correctCount == gameVM.fruitsOrder.count {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                gameVM.goToNextLevel()
            }
        }
    }
    
    //MARK: - Header
    
    @ViewBuilder
    private func Header() -> some View {
        VStack {
            ZStack(alignment: .top) {
                HStack {
                    LevelView(gameVM: gameVM)
                    
                    Spacer()
                    
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.white)
                        .onTapGesture {
                            hapticFeedback()
                            gameVM.isSettingsViewDisplayed.toggle()
                        }
                }
                CounterView(gameVM: gameVM)
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
            
            FruitView(gameVM: gameVM)
            
            Spacer()
        }
    }
    
    //MARK: - Tutorial View
    
    @ViewBuilder
    private func TutorialText() -> some View {
        VStack {
            Spacer()
            TutorialView(gameVM: gameVM)
        }.padding()
    }
    
    //MARK: - Success Animation
    
    @ViewBuilder
    private func SuccessAnimation(geometry: GeometryProxy) -> some View {
        if gameVM.showSuccessView {
            SuccessView()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scaleEffect(1.1)
        }
    }
    
    //MARK: - Settings View
    
    @ViewBuilder
    private func Settings() -> some View {
        if gameVM.isSettingsViewDisplayed {
            SettingsView(gameVM: gameVM)
        }
    }
    
    //MARK: - AdMob
    
    @ViewBuilder
    private func InterstitialAd() -> some View {
        gameVM.adViewControllerRepresentable
            .frame(width: .zero, height: .zero)
    }
}

#Preview {
    GameScreen()
}
