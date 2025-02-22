//
//  HoseChallenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 20/02/25.
//

import SwiftUI
struct Year1950Challenge: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    @State var start1950Challenge: Bool = false
    var body: some View {
        ZStack {
            Image("background1950")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                .ignoresSafeArea()
            if start1950Challenge == false {
                HStack {
                    Image("michelle")
                        .padding(.top, UIScreen.main.bounds.height * 0.4)
                    ZStack {
                        Image("speechBaloon")
                            .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                            .padding(.top, UIScreen.main.bounds.height * 0.7)
                        Button(action:{
                            start1950Challenge.toggle()
                        }, label: {
                            Image("timeTravelButton")
                        })
                        .padding(.leading, UIScreen.main.bounds.width * 0.4)
                        .padding(.top, UIScreen.main.bounds.height * 0.8)
                    }
                }
            }else{
                HunterView()
            }
        }
    }
}
