//
//  MainView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//
import SwiftUI

struct MainView: View {
    @StateObject var challengeViewModel = ChallengeViewModel()
    @State var showStartScreen: Bool = true
    var body: some View {
        ZStack {
           
            
            switch challengeViewModel.currentScreen {
            case .start:
                StartScreen()
            case .onboard:
                OnBoardScreen(showStartScreen: $showStartScreen)
            case .timeTravel:
                TimeTravelSlider()
            case .year1950:
                Year1950Challenge()
            case .hunter:
                HunterView()
            case .fireHose:
                FireHoseChallenge()
            case .year2025:
                Year2025Challenge()
            case .pollen:
                PollenView()
            case .year2100:
                Year2100View()
            case .between1950Challenges:
                Between1950Challenges()
            case .finished1950Challenges:
                Finished1950Challenges()
            case .finished2025Challenges:
                Finished2025Challenges()
            case .introView:
                IntroView()
            }
        }
        .environmentObject(challengeViewModel)
    }
}
