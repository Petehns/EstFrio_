//
//  IntroView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 22/02/25.
//
import SwiftUI
struct IntroView: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        VStack {
            Text("In 2100, the Atlantic Forest is nearly gone, devastated by decades of mass deforestation. By 2025, only 24% of its original coverage remained, marking a state of emergency.\nIn Paulista, Pernambuco, country of Brazil, the situation is even worse—scorching heat, dry rivers, and vanishing biodiversity have left the city unprotected. The air is polluted, and life in this biome has almost disappeared.\n")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.custom(.font, size: 24))
                .frame(width: UIScreen.main.bounds.width * 0.7)
                .padding()
            Button(action: {
                challengeViewModel.currentScreen = .onboard
            }, label: {Text("Tap here to start your adventure")
                    .foregroundStyle(.white)
                   
                    .font(.custom(.font, size: 28))
            })
                
            
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
