//
//  MonkeyAnimation.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct MonkeyAnimation: View {
    @State private var angle: Double = 0
    
    var body: some View {
        VStack {
            Image("sagui")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.19, height: UIScreen.main.bounds.height * 0.28)
                .rotationEffect(.degrees(angle), anchor: .top)
                .animation(
                    Animation.easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                    value: angle
                )
        }
        .offset(x: -380, y: -165)
        .onAppear {
            startPendulumAnimation()
        }
    }

    func startPendulumAnimation() {
        angle = 15 // Alterna para o lado oposto
    }
}


#Preview {
    MonkeyAnimation()
}
