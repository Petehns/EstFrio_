//
//  StartScreen.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//


import SwiftUI

struct StartScreen: View {
    @State var showStartScreen: Bool = true
    @ObservedObject var appState = ChallengeViewModel.shared
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
//                    Button(action: {
//                        showStartScreen.toggle()
//                    }, label: {
//                        Text("Iniciar")
//                            .font(.system(size: 40, weight: .bold))
//                            .foregroundStyle(.white)
//                    })
                    Button("Iniciar") {
                                   appState.currentScreen = .onboard
                               }
                    
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
