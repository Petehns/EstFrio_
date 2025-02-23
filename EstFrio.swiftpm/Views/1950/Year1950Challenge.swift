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
                    Image("michelleSad")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.35)
                        .padding(.top, UIScreen.main.bounds.height * 0.6)
                        .padding(.leading, UIScreen.main.bounds.width * 0.07)
                    ZStack {
                        Image("speechBaloon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.7)
                        
                        Text("I’m Michelle, a biologist studying the Atlantic Forest. We tried everything, but the truth is: the damage is irreversible.\nUnless… we change the past.\nOur only hope is to travel back to 1950, when the forest was still thriving, and stop this disaster before it's too late.")
                            .font(.custom(.font, size: 22))
                            .foregroundStyle(Color("greenEstFrio"))
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.3)
                            .padding(.trailing, UIScreen.main.bounds.width * 0.16)
                        Button(action:{

                            start1950Challenge.toggle()
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .foregroundStyle(Color("redEstFrio"))
                                    .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.07)
                                    .cornerRadius(20)
                                Text("Start challenge")
                                    .font(.custom(.font, size: 22))
                                    .foregroundStyle(.white)
                            }
                        })
                        .padding(.top, UIScreen.main.bounds.height * 0.135)
                        .padding(.leading, UIScreen.main.bounds.width * 0.51)
                        
                    }
                    
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.3)
                    .padding(.leading, UIScreen.main.bounds.width * 0.12)
                    .padding(.top, UIScreen.main.bounds.height * 0.7)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.29)
                }
                            
                        
            }else{
                HunterView()
            }
        }
    }
}
