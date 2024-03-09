//
//  GameManagerViewModel.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 11/02/24.
//

import Foundation

class GameManagerViewModel: ObservableObject {
    
    init() {
        createObservers()
        prepareLevel()
    }
    
    var correctCount: Int = 0
    @Published var level = LocalState.level {
        didSet {
            LocalState.level = level
        }
    }
    @Published var answer: [Fruit] = []
    @Published var fruitsOrder: [Fruit] = []
    @Published var selectedFruit: Fruit?
    
    func prepareLevel() {
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
    
    func swapElements(index1: Int, index2: Int) {
        if !LocalState.swappedFruits { countFirstSwappedFruits() }
        let temp = fruitsOrder[index1]
        fruitsOrder[index1] = fruitsOrder[index2]
        fruitsOrder[index2] = temp
        countCorrectFruits()
    }
    
    private func hasMatchingPositions(_ array1: [Fruit], _ array2: [Fruit]) -> Bool {
        return zip(array1, array2).contains { $0.0 == $0.1 }
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
    
    private func countCorrectFruits() {
        let matchingCount = zip(fruitsOrder, answer).reduce(0) { (count, pair) in
            return pair.0 == pair.1 ? count + 1 : count
        }
        if matchingCount > correctCount {
            correctCount = matchingCount
            playCorrectAudio()
        } else {
            correctCount = matchingCount
        }
    }
    
    @objc private func increaseLevel() {
        level += 1
        prepareLevel()
    }
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(increaseLevel), name: Notification.Name(Constants.increaseLevelNotificationKey), object: nil)
    }
    
    private func playCorrectAudio() {
        if !LocalState.isFXOff {
            let name = Notification.Name(Constants.playCorrectAudioNotificationKey)
            NotificationCenter.default.post(name: name, object: nil, userInfo: ["correctCount": String(correctCount)])
        }
    }
    
    private func countFirstSwappedFruits() {
        let name = Notification.Name(Constants.swappedFruitsNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
}
