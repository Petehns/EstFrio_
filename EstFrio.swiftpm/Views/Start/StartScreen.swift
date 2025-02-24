//
//  StartScreen.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//


import SwiftUI

struct StartScreen: View {
    @State var showStartScreen: Bool = true
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        
        if showStartScreen == true {
            
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                    .ignoresSafeArea(.all)
                VStack {
                    
                    Image("estFrio")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.52 , height: UIScreen.main.bounds.height * 0.256)
                        .padding(.top, UIScreen.main.bounds.height * 0.055)
                    
                    Spacer()
                    
                    Button(action: {
                        challengeViewModel.currentScreen = .introView
                    }, label: {
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color("yellowEstFrio"))
                                .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.07)
                                .cornerRadius(20)
                            Text("Start")
                                .foregroundStyle(Color("redEstFrio"))
                                .font(.custom(.font, size: 40))
                        }
                    })
                   
                    
                }
                .padding(UIScreen.main.bounds.height*0.2)
                OunceAnimation()
                
                MonkeyAnimation()
                LeafAnimation()
            }
        }else{
            OnBoardScreen(showStartScreen: $showStartScreen)
        }
    }
}

#Preview {
    StartScreen()
}
