//
//  AdBannerView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 29/01/24.
//

import SwiftUI
import GoogleMobileAds

protocol ThemeSongDelegate {
    func stopThemeSongDuringAd()
    func resumeThemeSongAfterAd()
}

class AdCoordinator: NSObject, GADFullScreenContentDelegate {
    
    private var ad: GADInterstitialAd?
    
    var themeSongDelegate: ThemeSongDelegate?
    
    func loadAd() {
        GADInterstitialAd.load(
            withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: GADRequest()
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
        themeSongDelegate?.stopThemeSongDuringAd()
    }
    
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("\(#function) called")
        themeSongDelegate?.resumeThemeSongAfterAd()
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
