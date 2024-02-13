//
//  GameViewModel.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import Foundation

class GameViewModel: ObservableObject {
    
    init() {
        addObservers()
        setupGame()
    }
    
    @Published var isSettingsViewDisplayed: Bool = false
    @Published var showSuccessView: Bool = false
    @Published var swappedFruits: Bool = LocalState.swappedFruits {
        didSet {
            LocalState.swappedFruits = swappedFruits
        }
    }
    @Published var isMusicOff: Bool = LocalState.isMusicOff {
        didSet {
            LocalState.isMusicOff = isMusicOff
            if isMusicOff {
                stopThemeSong()
            } else {
                playThemeSong()
            }
        }
    }
    @Published var isFXOff: Bool = LocalState.isFXOff {
        didSet {
            LocalState.isFXOff = isFXOff
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(countFirstSwappedFruits), name: Notification.Name(Constants.swappedFruitsNotificationKey), object: nil)
    }
    
    func goToNextLevel() {
        if !isFXOff { playSuccessAudio() }
        showSuccessView = true
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.showSuccessView = false
            self.processAd()
            self.increaseLevel()
        }
    }
    
    private func setupGame() {
        if !isMusicOff { playThemeSong() }
        processAd()
    }
    
    private func increaseLevel() {
        let name = Notification.Name(Constants.increaseLevelNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    @objc private func countFirstSwappedFruits() {
        swappedFruits = true
    }
}

// Audio 📣

extension GameViewModel {
    private func playThemeSong() {
        let name = Notification.Name(Constants.playThemeSongNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    private func stopThemeSong() {
        let name = Notification.Name(Constants.stopThemeSongNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    private func playSuccessAudio() {
        let name = Notification.Name(Constants.playSuccessAudioNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
}

// AdMob 📲

extension GameViewModel {
    private func processAd() {
        let name = Notification.Name(Constants.processAdNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
}
