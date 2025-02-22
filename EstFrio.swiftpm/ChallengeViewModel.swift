//
//  ChallengeViewMoswl.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

@MainActor
class ChallengeViewModel: ObservableObject {
//    static let shared = ChallengeViewModel() // Singleton
    
    @Published var currentScreen: AppScreen = .start
    @Published var completed1950Challenges = false
    @Published var completed2025Challenge = false
    @Published var backgroundImage: String = "background2100"

    func travelToYear(_ year: Int) {
        switch year {
        case 1950:
            currentScreen = .year1950
        case 2025:
            currentScreen = .year2025
        case 2100:
            if completed1950Challenges && completed2025Challenge {
                backgroundImage = "background" // Muda o fundo ao final
            }
            currentScreen = .year2100
        default:
            break
        }
    }
    
    func completeHunterChallenge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.currentScreen = .between1950Challenges
        }
    }
    
    func completeFireHoseChallenge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.completed1950Challenges = true
            self.currentScreen = .finished1950Challenges
        }
    }
    
    func completePollenChallenge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.completed2025Challenge = true
            self.currentScreen = .finished2025Challenges
        }
    }
}

enum AppScreen {
    case start, onboard, timeTravel, destination, year1950, hunter, fireHose, year2025, pollen, year2100, between1950Challenges, finished1950Challenges, finished2025Challenges
}

