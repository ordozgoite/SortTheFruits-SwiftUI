//
//  AdManagerViewModel.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 12/02/24.
//

import Foundation

class AdManager {
    
    init() {
        addObservers()
    }
    
    let adViewControllerRepresentable = AdViewControllerRepresentable()
    private let adCoordinator = AdCoordinator()
    private var levelsBeetweenAdsCounter: Int = 0
    private let levelsBeforeAdDisplay = 3
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(processAd), name: Notification.Name(Constants.processAdNotificationKey), object: nil)
    }
    
    @objc private func processAd() {
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
