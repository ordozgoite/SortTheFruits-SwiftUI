//
//  LevelView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 28/01/24.
//

import SwiftUI

struct LevelView: View {
    
    @Binding var level: Int
    
    var body: some View {
        Text("level-string \(String(level))")
            .foregroundStyle(.white)
            .font(.title3)
            .fontWeight(.medium)
    }
}

#Preview {
    LevelView(level: .constant(1))
}
