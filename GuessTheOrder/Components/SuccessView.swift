//
//  SuccessView.swift
//  GuessTheOrder
//
//  Created by Victor Ordozgoite on 27/01/24.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        ZStack {
            LottieView(name: "confetti", loopMode: .playOnce)
            
//            Text("YOU DID IT!")
//                .font(.system(size: 48))
//                .fontWeight(.black)
//                .foregroundStyle(.white)
        }
    }
}

#Preview {
    SuccessView()
}
