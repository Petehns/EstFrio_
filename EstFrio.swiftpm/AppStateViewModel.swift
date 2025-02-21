////
////  AppStateViewModel.swift
////  EstFrio
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
////
//
//import SwiftUI
//
//class AppStateViewModel: ObservableObject {
//    static let shared = AppStateViewModel() // Singleton
//    
//    @Published var currentScreen: AppScreen = .start
//    @Published var completed1950Challenges = false
//    @Published var completed2025Challenge = false
//    @Published var backgroundImage: String = "background2100"
//
//    func travelToYear(_ year: Int) {
//        switch year {
//        case 1950:
//            currentScreen = .year1950
//        case 2025:
//            currentScreen = .year2025
//        case 2100:
//            if completed1950Challenges && completed2025Challenge {
//                backgroundImage = "background" // Muda o fundo ao final
//            }
//            currentScreen = .year2100
//        default:
//            break
//        }
//    }
//    
//    func completeHunterChallenge() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
//            self.currentScreen = .fireHose
//        }
//    }
//    
//    func completeFireHoseChallenge() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
//            self.completed1950Challenges = true
//            self.currentScreen = .timeTravel
//        }
//    }
//    
//    func completePollenChallenge() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            self.completed2025Challenge = true
//            self.currentScreen = .timeTravel
//        }
//    }
//}
//
//enum AppScreen {
//    case start, onboard, timeTravel, destination, year1950, hunter, fireHose, year2025, pollen, year2100
//}
