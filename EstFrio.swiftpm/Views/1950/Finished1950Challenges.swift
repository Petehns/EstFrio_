//
//  FinishedChallenges.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

struct Finished1950Challenges: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        ZStack {
            Image("background1950")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                .ignoresSafeArea()
            HStack {
                Image("michelle")
                    .padding(.top, UIScreen.main.bounds.height * 0.4)
                ZStack {
                    Image("speechBaloon")
                        .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                        .padding(.top, UIScreen.main.bounds.height * 0.7)
                    Button(action:{
                   
                        challengeViewModel.currentScreen = .timeTravel
                    }, label: {
                        Image("timeTravelButton")
                    })
                    .padding(.leading, UIScreen.main.bounds.width * 0.4)
                    .padding(.top, UIScreen.main.bounds.height * 0.8)
                }
            }
        }
    }
}
