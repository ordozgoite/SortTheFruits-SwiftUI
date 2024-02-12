//
//  GameViewModel.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import Foundation
import AVFoundation

class GameViewModel: ObservableObject, ThemeSongDelegate {
    
    init() {
        adCoordinator.themeSongDelegate = self
        startGame()
    }
    
    // Game Logic
    var correctCount: Int = 0
    @Published var level = LocalState.level {
        didSet {
            LocalState.level = level
        }
    }
    @Published var answer: [Fruit] = []
    @Published var fruitsOrder: [Fruit] = []
    @Published var selectedFruit: Fruit?
    @Published var showSuccessView: Bool = false
    @Published var swappedFruits: Bool = LocalState.swappedFruits {
        didSet {
            LocalState.swappedFruits = swappedFruits
        }
    }
    
    // Audio
    @Published var audioPlayer: AVAudioPlayer?
    @Published var themeSongPlayer: AVAudioPlayer?
    
    // Settings
    @Published var isSettingsViewDisplayed: Bool = false
    @Published var isMusicOff: Bool = LocalState.isMusicOff {
        didSet {
            LocalState.isMusicOff = isMusicOff
            if isMusicOff {
                themeSongPlayer?.stop()
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
    
    // AdMob
    let adViewControllerRepresentable = AdViewControllerRepresentable()
    private let adCoordinator = AdCoordinator()
    private var levelsBeetweenAdsCounter: Int = 0
    private let levelsBeforeAdDisplay = 3
    
    func swapElements(index1: Int, index2: Int) {
        if !swappedFruits { swappedFruits = true }
        let temp = fruitsOrder[index1]
        fruitsOrder[index1] = fruitsOrder[index2]
        fruitsOrder[index2] = temp
        countCorrectFruits()
    }
    
    func goToNextLevel() {
        playAudio("success")
        showSuccessView = true
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.showSuccessView = false
            self.level += 1
            self.prepareLevel()
        }
        
    }
    
    private func startGame() {
        playThemeSong()
        prepareLevel()
    }
    
    private func prepareLevel() {
        processAd()
        correctCount = 0
        sortAnswer()
        sortFruitsOrder()
    }
    
    private func sortAnswer() {
        answer = Fruit.allCasesArray.prefix(getFruitsQuantity()).shuffled()
        print("🍉 Secret: \(answer)")
    }
    
    private func sortFruitsOrder() {
        var shuffledFruits = Fruit.allCasesArray.prefix(getFruitsQuantity()).shuffled()
        while hasMatchingPositions(answer, shuffledFruits) {
            shuffledFruits.shuffle()
        }
        fruitsOrder = shuffledFruits
    }
    
    private func getFruitsQuantity() -> Int {
        switch level {
        case 1 ..< 5:
            return 4
        case 5 ..< 40:
            return 5
        case 40 ..< 70:
            return 6
        case 70 ..< 100:
            return 7
        default:
            return 8
            
        }
    }
    
    private func hasMatchingPositions(_ array1: [Fruit], _ array2: [Fruit]) -> Bool {
        return zip(array1, array2).contains { $0.0 == $0.1 }
    }
    
    private func countCorrectFruits() {
        let matchingCount = zip(fruitsOrder, answer).reduce(0) { (count, pair) in
            return pair.0 == pair.1 ? count + 1 : count
        }
        if matchingCount > correctCount {
            correctCount = matchingCount
            playAudio(String(correctCount))
        } else {
            correctCount = matchingCount
        }
    }
    
    //MARK: - Audio 📣
    
    func playAudio(_ audioName: String) {
        if !isFXOff {
            guard let path = Bundle.main.path(forResource: audioName, ofType: "mp3") else {
                print("Audio file not found")
                return
            }
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                print("🎶 Played sound \(audioName)")
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }
    
    func playThemeSong() {
        if !isMusicOff {
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
    
    func stopThemeSongDuringAd() {
        themeSongPlayer?.stop()
    }
    
    func resumeThemeSongAfterAd() {
        if !isMusicOff {
            playThemeSong()
        }
    }
    
    //MARK: - AdMob 📲
    
    private func processAd() {
        if levelsBeetweenAdsCounter == levelsBeforeAdDisplay {
            playAd()
            levelsBeetweenAdsCounter = 0
        } else {
            loadAd()
            levelsBeetweenAdsCounter += 1
        }
    }
    
    private func loadAd() {
        adCoordinator.loadAd()
    }
    
    private func playAd() {
        adCoordinator.presentAd(from: adViewControllerRepresentable.viewController)
    }
}
