//
//  HunterView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 19/02/25.
//

import SwiftUI

struct HunterView: View {
    struct Enemy: Identifiable {
        let id = UUID()
        var position: CGPoint
        var imageName: String
    }
    
    @State private var enemies: [Enemy] = []
    @State private var timer: Timer?
    let enemyImages = ["leaf1", "leaf2"] // Substitua pelos nomes das imagens no Assets
    let gameTime: TimeInterval = 2.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background2025")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                ForEach(enemies) { enemy in
                    Image(enemy.imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .position(enemy.position)
                        .onTapGesture {
                            removeEnemy(enemy)
                        }
                }
            }
            .onAppear {
                startGame(in: geometry.size)
            }
        }
    }
    
    func startGame(in size: CGSize) {
        spawnEnemy(in: size) // Garante a primeira aparição
        timer = Timer.scheduledTimer(withTimeInterval: gameTime, repeats: true) { _ in
            DispatchQueue.main.async {
                spawnEnemy(in: size) // Agora rodando na Main Thread
            }
        }
    }

    
    func spawnEnemy(in size: CGSize) {
        let newEnemy = Enemy(
            position: CGPoint(
                x: CGFloat.random(in: 50...(size.width - 50)),
                y: CGFloat.random(in: 50...(size.height - 50))
            ),
            imageName: enemyImages.randomElement()!
        )
        
        enemies.append(newEnemy)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + gameTime) {
            enemies.removeAll { $0.id == newEnemy.id }
        }
    }
    
    func removeEnemy(_ enemy: Enemy) {
        enemies.removeAll { $0.id == enemy.id }
    }
}

struct HunterGameView_Previews: PreviewProvider {
    static var previews: some View {
        HunterView()
    }
}
