//
//  AudioManager.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 12/02/24.
//

import Foundation
import AVFoundation

class AudioManager {
    
    init() {
        createObservers()
    }
    
    private var audioPlayer: AVAudioPlayer?
    private var themeSongPlayer: AVAudioPlayer?
    
    private func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(playThemeSong), name: Notification.Name(Constants.playThemeSongNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopThemeSong), name: Notification.Name(Constants.stopThemeSongNotificationKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playSuccessAudio), name: Notification.Name(Constants.playSuccessAudioNotificationKey), object: nil)
        NotificationCenter.default.addObserver(forName: Notification.Name(Constants.playCorrectAudioNotificationKey), object: nil, queue: nil) { notification in
            if let userInfo = notification.userInfo, let correctCount = userInfo["correctCount"] as? String {
                self.playCorrectAudio(for: correctCount)
                }
        }
    }
    
    @objc private func playThemeSong() {
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
    
    @objc private func stopThemeSong() {
        themeSongPlayer?.stop()
    }
    
    @objc private func playCorrectAudio(for correctCount: String) {
        playAudio(correctCount)
    }
    
    @objc private func playSuccessAudio() {
        playAudio("success")
    }
    private func playAudio(_ audioName: String) {
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
