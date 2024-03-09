//
//  SettingsView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var gameVM: SinglePlayViewModel
    
    var body: some View {
        ZStack {
            Header()
            
            Options()
        }
        .padding()
        .frame(width: screenWidth - 128, height: 200)
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 8, style: .continuous))
    }
    
    //MARK: - Header View
    
    @ViewBuilder
    private func Header() -> some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "x.circle.fill")
                    .foregroundStyle(.white)
                    .onTapGesture {
                        hapticFeedback()
                        gameVM.isSettingsViewDisplayed = false
                    }
            }
            Spacer()
        }
    }
    
    //MARK: - Options View
    
    @ViewBuilder
    private func Options() -> some View {
        VStack {
            Text("menu-string")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            HStack(spacing: 32) {
                MusicButton()
                
                AudioFXButton()
            }
            
            Spacer()
        }
    }
    
    //MARK: - Music Button
    
    @ViewBuilder
    private func MusicButton() -> some View {
        VStack {
            Image(systemName: gameVM.isMusicOff ? "speaker.slash" : "music.note")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
                .onTapGesture {
                    hapticFeedback()
                    gameVM.isMusicOff.toggle()
                }
            
            Text("music-string")
                .foregroundStyle(.white)
        }
    }
    
    //MARK: - FX Button
    
    @ViewBuilder
    private func AudioFXButton() -> some View {
        VStack {
            Image(systemName: gameVM.isFXOff ? "speaker.slash.fill" : "speaker.wave.2.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
                .onTapGesture {
                    hapticFeedback()
                    gameVM.isFXOff.toggle()
                }
            
            Text("fx-string")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SettingsView(gameVM: SinglePlayViewModel())
}
