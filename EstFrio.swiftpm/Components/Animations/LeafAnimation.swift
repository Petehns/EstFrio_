//
//  LeafAnimation.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct LeafAnimation: View {
    struct Leaf: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var rotation: Double
        var opacity: Double
        @State var imageIndex: Int
    }
    
    let qtdPlantas = 5
    let leafImages = ["leaf1", "leaf2", "leaf3", "leaf4", "leaf5"]
    @State private var leaves: [Leaf] = []
    
    var body: some View {
        ZStack {
            ForEach(leaves.indices, id: \ .self) { index in
                Image(leafImages[leaves[index].imageIndex])
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.05, height: UIScreen.main.bounds.height * 0.08)
                    .position(x: leaves[index].x, y: leaves[index].y)
                    .rotationEffect(.degrees(leaves[index].rotation))
                    .opacity(leaves[index].opacity)
                    .onAppear {
                        animateLeaf(index)
                        cycleImages(index)
                    }
            }
        }
        .onAppear {
            setupLeaves()
        }
    }
    
    func setupLeaves() {
        leaves = (0..<qtdPlantas).map { _ in
            Leaf(
                x: CGFloat.random(in: 0..<UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0..<UIScreen.main.bounds.height),
                rotation: Double.random(in: 0..<360),
                opacity: Double.random(in: 0.5...1.0),
                imageIndex: Int.random(in: 0..<leafImages.count)
            )
        }
    }
    
    func animateLeaf(_ index: Int) {
        withAnimation(Animation.linear(duration: Double.random(in: 3...6)).repeatForever(autoreverses: true)) {
            leaves[index].x = CGFloat.random(in: 0..<UIScreen.main.bounds.width)
            leaves[index].y = CGFloat.random(in: 0..<UIScreen.main.bounds.height)
            leaves[index].opacity = Double.random(in: 0.5...1.0)
        }
        
        withAnimation(Animation.linear(duration: Double.random(in: 2...4)).repeatForever(autoreverses: false)) {
            leaves[index].rotation += 360
        }
    }
    
    func cycleImages(_ index: Int) {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                    leaves[index].imageIndex = (leaves[index].imageIndex + 1) % leafImages.count
                }
            }
        }
    }
    
    
    struct FloatingLeavesView_Previews: PreviewProvider {
        static var previews: some View {
            LeafAnimation()
        }
    }
}
