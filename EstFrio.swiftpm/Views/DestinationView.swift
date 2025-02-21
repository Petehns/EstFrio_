//
//  DestinationView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 19/02/25.
//

import SwiftUI

struct DestinationView: View {
    let year: Int
//    @StateObject var challengeViewModel = ChallengeViewModel()
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    var body: some View {
        VStack {
         
            // Aqui você pode adicionar conteúdo específico para cada ano
            if year == 1950 {
                Year1950Challenge()
            } else if year == 2025 {
                PollenView()
            } else if year == 2100 {
                Text("O futuro da floresta depende das suas ações!")
            }
            
        }
        .environmentObject(challengeViewModel)
    }
}
