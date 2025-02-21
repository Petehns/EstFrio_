//
//  OunceAnimation.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct OunceAnimation: View {
    let images = ["onca1", "onca2"]
    @State private var currentIndex = 0
    @State private var opacity = 1.0

    var body: some View {
        ZStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.23, height: UIScreen.main.bounds.height * 0.2)
                .opacity(opacity)
                .animation(.linear(duration: 1.0), value: opacity)
                .offset(x: 200, y: 190)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                DispatchQueue.main.async {
                    withAnimation {
                        opacity = 1.0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    currentIndex = (currentIndex + 1) % images.count
                    withAnimation {
                        opacity = 1.0
                    }
                }
            }
        }
    }
}
