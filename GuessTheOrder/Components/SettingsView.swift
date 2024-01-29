//
//  SettingsView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var gameVM: GameViewModel
    
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
            Text("Menu")
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
            Image(systemName: gameVM.isMusicOn ? "music.note" : "speaker.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
                .onTapGesture {
                    gameVM.isMusicOn.toggle()
                }
            
            Text("Music")
                .foregroundStyle(.white)
        }
    }
    
    //MARK: - FX Button
    
    @ViewBuilder
    private func AudioFXButton() -> some View {
        VStack {
            Image(systemName: gameVM.isFXOn ? "speaker.wave.2.fill" : "speaker.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
                .onTapGesture {
                    gameVM.isFXOn.toggle()
                }
            
            Text("Effects")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SettingsView(gameVM: GameViewModel())
}
