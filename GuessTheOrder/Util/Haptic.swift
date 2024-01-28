//
//  Haptic.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import Foundation
import SwiftUI
import CoreHaptics

public func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
    feedbackGenerator.prepare()
    feedbackGenerator.impactOccurred()
}

//public func triggerHapticFeedback() {
//    // Verificar se o dispositivo suporta feedback háptico
//    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//    
//    // Criar um evento háptico
//    do {
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
//        let event = try CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        
//        // Criar um padrão háptico
//        let pattern = try CHHapticPattern(events: [event], parameters: [])
//        
//        // Criar um player háptico e reproduzir o padrão
//        let player = try engine?.makePlayer(with: pattern)
//        try player?.start(atTime: CHHapticTimeImmediate)
//    } catch {
//        print("Erro ao acionar feedback háptico: \(error)")
//    }
//}
