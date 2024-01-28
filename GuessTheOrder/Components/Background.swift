//
//  Background.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.purple, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Background()
}
