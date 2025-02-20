//
//  HoseChallenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 20/02/25.
//

import SwiftUI
struct HoseChallenge: View {
    var body: some View {
        ZStack {
            Image("background2025")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            FireHoseView(motionManager: MotionManager())
        }
    }
}
