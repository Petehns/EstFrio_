//
//  OnBoardScreen.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//


import SwiftUI

struct OnBoardScreen: View {
    var body: some View {
        VStack {
            Image(systemName: "michelle")
                .imageScale(.large)
                .foregroundStyle(.black)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    OnBoardScreen()
}
