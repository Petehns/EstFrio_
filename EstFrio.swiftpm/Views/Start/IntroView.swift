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
            Text("It is the year 2100, and the Atlantic Forest has almost completely disappeared due to massive deforestation. By 2025, only about 25% of its original coverage remained, declaring an environmental emergency.\nIn the state of Pernambuco (Brazil), the destruction is total: extreme temperatures, dry rivers, and lost biodiversity. Polluted air and species extinction have made life nearly impossible. The situation seems irreversible...\nBut what if there was one last hope?")
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
