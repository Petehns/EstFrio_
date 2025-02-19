//
//  MonkeyAnimation.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct MonkeyAnimation: View {
    @State private var angle: Double = -30 // Ângulo inicial do pêndulo
    
    var body: some View {
        VStack {
            Image(systemName: "monkey") // Substitua pela imagem desejada
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(angle), anchor: .top) // Define o ponto de rotação no topo
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: angle
                )
        }
        
        .onAppear {
            startPendulumAnimation()
        }
    }

    func startPendulumAnimation() {
        angle = 30 // Alterna para o lado oposto
    }
}


#Preview {
    MonkeyAnimation()
}
