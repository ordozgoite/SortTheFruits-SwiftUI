//
//  GameViewModel.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import Foundation
import AVFoundation

class GameViewModel: ObservableObject {
    
    init() {
        startGame()
    }
    
    var correctCount: Int = 0
    
    @Published var level = 1
    @Published var answer: [Fruit] = []
    @Published var fruitsOrder: [Fruit] = []
    @Published var selectedFruit: Fruit?
    @Published var showSuccessView: Bool = false
    @Published var swappedFruits: Bool = false
    
    @Published var audioPlayer: AVAudioPlayer?
    
    func swapElements(index1: Int, index2: Int) {
        if !swappedFruits { countFirstSwap() }
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
        loadLevel()
        prepareLevel()
    }
    
    private func prepareLevel() {
        correctCount = 0
        saveLevel()
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
    
    private func saveLevel() {
        UserDefaults.standard.set(level, forKey: "level")
    }
    
    private func loadLevel() {
        let levelSaved = UserDefaults.standard.integer(forKey: "level")
        if levelSaved == 0 {
            level = 1
        } else {
            level = levelSaved
        }
        
        swappedFruits = UserDefaults.standard.bool(forKey: "swappedFruits")
        print("👉 Swapped Fruits: \(swappedFruits)")
    }
    
    private func countFirstSwap() {
        swappedFruits = true
        UserDefaults.standard.set(swappedFruits, forKey: "swappedFruits")
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
    
    func playAudio(_ audioName: String) {
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
