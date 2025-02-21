//
//  OnBoardScreen.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//


import SwiftUI

struct OnBoardScreen: View {
    @Binding var showStartScreen: Bool
    @State var timeTravelisOn: Bool = false
//    @ObservedObject var appState = ChallengeViewModel.shared
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        if timeTravelisOn == false {
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Image("michelle")
                            .padding(.top, UIScreen.main.bounds.height * 0.4)
                        ZStack {
                            Image("speechBaloon")
                                .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                                .padding(.top, UIScreen.main.bounds.height * 0.7)
                            Button(action:{
//                                timeTravelisOn.toggle()
                                challengeViewModel.currentScreen = .timeTravel
                            }, label: {
                                Image("timeTravelButton")
                            })
                            .padding(.leading, UIScreen.main.bounds.width * 0.4)
                            .padding(.top, UIScreen.main.bounds.height * 0.8)
                        }
                    }
                }
                
                Button(action: {showStartScreen = true}, label: {Text("voltar")})
            }
        }else {
            TimeTravelSlider()
        }
    }
}

#Preview {
    OnBoardScreen(showStartScreen: .constant(false))
}
