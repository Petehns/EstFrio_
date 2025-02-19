//
//  StartScreen.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//


import SwiftUI

struct StartScreen: View {
    @State var showStartScreen: Bool = true
    var body: some View {
        
        if showStartScreen == true {
            
            ZStack {
                Image("background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack {
                   Image("estFrio")
                        .resizable()
                        .scaledToFit()
                        
                    Spacer()
                    Button(action: {
                        showStartScreen.toggle()
                    }, label: {
                        Text("Iniciar")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.white)
                    })
                    OunceAnimation()
                    MonkeyAnimation()
                    LeafAnimation()
                }
                .padding(UIScreen.main.bounds.height*0.2)
            }
        }else{
            OnBoardScreen()
        }
    }
}

#Preview {
    StartScreen()
}
