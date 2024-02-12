//
//  LocalState.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 11/02/24.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case level
        case swappedFruits
        case isMusicOff
        case isFXOff
    }
    
    public static var level: Int {
        get {
            let level = UserDefaults.standard.integer(forKey: Keys.level.rawValue)
            return level == 0 ? 1 : level
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.level.rawValue)
        }
    }
    
    public static var swappedFruits: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.swappedFruits.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.swappedFruits.rawValue)
        }
    }
    
    public static var isMusicOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isMusicOff.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isMusicOff.rawValue)
        }
    }
    
    public static var isFXOff: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.isFXOff.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isFXOff.rawValue)
        }
    }
}
