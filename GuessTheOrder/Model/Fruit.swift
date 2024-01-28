//
//  Fruit.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import Foundation

enum Fruit: CaseIterable, Equatable {
    case apple
    case banana
    case grape
    case kiwi
    case orange
    case peach
    case pineapple
    case strawberry
    
    var name: String {
        switch self {
        case .apple:
            return "apple"
        case .banana:
            return "banana"
        case .orange:
            return "orange"
        case .strawberry:
            return "strawberry"
        case .grape:
            return "grape"
        case .kiwi:
            return "kiwi"
        case .peach:
            return "peach"
        case .pineapple:
            return "pineapple"
        }
    }
    
    var emoji: String {
        switch self {
        case .apple:
            return "🍎"
        case .banana:
            return "🍌"
        case .orange:
            return "🍊"
        case .strawberry:
            return "🍓"
        case .grape:
            return "🍇"
        case .kiwi:
            return "🥝"
        case .peach:
            return "🍑"
        case .pineapple:
            return "🍍"
        }
    }
    
    static var allCasesArray: [Fruit] {
        return allCases
    }
}
