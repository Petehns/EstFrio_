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
    let enemyImages = ["logger1", "logger2"]
    let gameTime: TimeInterval = 2.0
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
              
                Image("background1950")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                    .ignoresSafeArea()
                ZStack{
                    Rectangle()
                        .foregroundStyle(Color("yellowEstFrio"))
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.1)
                        .cornerRadius(20)
                    Text("Tap the loggers to make them disappear")
                        .font(.custom(.font, size: 25))
                        .foregroundStyle(Color("redEstFrio"))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.8)
                ForEach(enemies) { enemy in
                    Image(enemy.imageName)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.height * 0.19)
                        .position(enemy.position)
                        .onTapGesture {
                            removeEnemy(enemy)
                        }
                }
            }
            .onAppear {
                startGame(in: geometry.size)
                challengeViewModel.completeHunterChallenge()
            }
        }
    }
    
    func startGame(in size: CGSize) {
        spawnEnemy(in: size)
        timer = Timer.scheduledTimer(withTimeInterval: gameTime, repeats: true) { _ in
            DispatchQueue.main.async {
                spawnEnemy(in: size) 
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
