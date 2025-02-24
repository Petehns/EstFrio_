//
//  FinishGame.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 23/02/25.
//

import SwiftUI
struct FinishGame: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        VStack {
            Text("The Atlantic Forest is one of the richest biomes in biodiversity in the world, home to thousands of plant and animal species that exist nowhere else. Additionally, it plays a key role in regulating the climate, producing water, and maintaining the air quality we breathe. Protecting this forest is not only an environmental issue but also a matter of survival for all of us.\nThank you for helping us save our planet and this very special biome. In the real world, we still need heroes like you. Keep fighting for nature!")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.custom(.font, size: 28))
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .padding()
            Button(action: {
                challengeViewModel.currentScreen = .start
            }, label: {Text("Tap here to finish your adventure")
                    .foregroundStyle(.white)
                   
                    .font(.custom(.font, size: 30))
            })
                
            .padding(.top, UIScreen.main.bounds.height * 0.2)
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            Image("backgroundIntro")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
        )
    }
}
