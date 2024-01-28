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
    @State private var themeSongPlayer: AVAudioPlayer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Background()
                
                Header()
                
                Fruits()
                
                TutorialText()
                
                SuccessAnimation(geometry: geometry)
            }
        }
        .onAppear {
            playThemeSong()
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
        .padding()
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
    
    //MARK: - Auxiliary Methods
    
    private func playThemeSong() {
        guard let path = Bundle.main.path(forResource: "theme", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        do {
            themeSongPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            themeSongPlayer?.numberOfLoops = -1
            themeSongPlayer?.prepareToPlay()
            themeSongPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    GameScreen()
}
