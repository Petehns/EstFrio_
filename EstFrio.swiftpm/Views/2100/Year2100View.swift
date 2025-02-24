//
//  Year2100View.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

struct Year2100View: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    @State private var buttonTitle = "Next"
    @State private var displayText = "You did it! Your actions changed the future, and the Atlantic Forest is alive again. The air is fresh, the rivers flow freely, and the animals that were once on the brink of extinction are now thriving."
    @State private var isNextButtonPressed = false
    
    var body: some View {
        ZStack {
            Image("background1950")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                .ignoresSafeArea()
            
            HStack {
                Image("michelleHappy")
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
                    
                    Text(displayText)
                        .font(.custom(.font, size: 22))
                        .foregroundStyle(Color("greenEstFrio"))
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.3)
                        .padding(.trailing, UIScreen.main.bounds.width * 0.16)
                    
                    Button(action: {
                        if !isNextButtonPressed {
                            isNextButtonPressed = true
                        
                            displayText = "Paulista, which once suffered from extreme heat and pollution, has become an example of sustainability, showing that coexistence between progress and nature is possible.\nAnd we now we know that to keep the environment alive we need to keep doing these actions from now on!"
                            buttonTitle = "Finish Odyssey"
                        } else {
    
                            challengeViewModel.currentScreen = .finishGame
                        }
                    }, label: {
                        ZStack{
                            Rectangle()
                                .foregroundStyle(Color("redEstFrio"))
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.07)
                                .cornerRadius(20)
                            Text(buttonTitle)
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
        }
    }
}

