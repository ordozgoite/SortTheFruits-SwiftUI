//
//  AdBannerView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 29/01/24.
//

import SwiftUI
import GoogleMobileAds

class AdCoordinator: NSObject, GADFullScreenContentDelegate {
    
    private var ad: GADInterstitialAd?
    
    func loadAd() {
        GADInterstitialAd.load(
            withAdUnitID: "ca-app-pub-6087487866138852/2530987463", request: GADRequest()
        ) { ad, error in
            if let error = error {
                return print("Failed to load ad with error: \(error.localizedDescription)")
            }
            
            self.ad = ad
            self.ad?.fullScreenContentDelegate = self
        }
    }
    
    func presentAd(from viewController: UIViewController) {
        guard let fullScreenAd = ad else {
            return print("Ad wasn't ready")
        }
        
        fullScreenAd.present(fromRootViewController: viewController)
    }
    
    // MARK: - GADFullScreenContentDelegate methods
    
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("\(#function) called")
    }
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        if !LocalState.isMusicOff { stopThemeSong() }
    }
    
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        if !LocalState.isMusicOff { playThemeSong() }
    }
}

// Audio 📣

extension AdCoordinator {
    private func playThemeSong() {
        let name = Notification.Name(Constants.playThemeSongNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    private func stopThemeSong() {
        let name = Notification.Name(Constants.stopThemeSongNotificationKey)
        NotificationCenter.default.post(name: name, object: nil)
    }
}

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // No implementation needed. Nothing to update.
    }
}
