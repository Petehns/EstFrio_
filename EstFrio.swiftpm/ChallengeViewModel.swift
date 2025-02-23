//
//  ChallengeViewMoswl.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

@MainActor
class ChallengeViewModel: ObservableObject {
    
    @Published var currentScreen: AppScreen = .start
    @Published var backgroundImage: String = "background2100"
    @Published var completed1950Challenges = false
    @Published var completed2025Challenge = false
    @Published var completed2100Challenge = false
    @Published var alertMessage: String? = nil

    func travelToYear(_ year: Int) {
        switch year {
        case 1950:
            if !completed1950Challenges{
                currentScreen = .year1950
            }else{
                alertMessage = "You have already visited the year of 1950\nGo to the next year"
                
            }
            if completed1950Challenges && completed2025Challenge {
                alertMessage = "You have finished all the challenges\nNow you can travel back to the year 2100"
            }
        case 2025:
            if completed1950Challenges && !completed2025Challenge {
                currentScreen = .year2025
            }else{
                alertMessage = "Please start your odissey in the year of 1950"
            }
            if completed1950Challenges && completed2025Challenge {
                alertMessage = "You have finished all the challenges\nNow you can travel back to the year 2100"
            }
        case 2100:
            if completed1950Challenges && completed2025Challenge && !completed2100Challenge {
                backgroundImage = "background"
                
                currentScreen = .year2100
            }else{
                alertMessage = "Finish all challenges to go back to the year of 2100"
            }
        default:
            break
        }
    }
    
    func completeHunterChallenge() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.completed2025Challenge = true
            self.currentScreen = .finished2025Challenges
        }
    }
}

enum AppScreen {
    case start, onboard, timeTravel, year1950, hunter, fireHose, year2025, pollen, year2100, between1950Challenges, finished1950Challenges, finished2025Challenges, introView
}

