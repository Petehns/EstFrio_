//
//  HoseChallenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 20/02/25.
//

import SwiftUI
struct Year1950Challenge: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        ZStack {
            Image("background1950")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                .ignoresSafeArea()
            
            HunterView()
            FireHoseView(motionManager: MotionManager())
        }
    }
}
