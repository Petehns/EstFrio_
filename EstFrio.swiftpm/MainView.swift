//
//  MainView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//
import SwiftUI

struct MainView: View {
    @ObservedObject var appState = ChallengeViewModel.shared
    @State var showStartScreen: Bool = true
    var body: some View {
        ZStack {
            Image(appState.backgroundImage)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            switch appState.currentScreen {
            case .start:
                StartScreen()
            case .onboard:
                OnBoardScreen(showStartScreen: $showStartScreen)
            case .timeTravel:
                TimeTravelSlider()
            case .destination:
                DestinationView(year: 2100)
            case .year1950:
                Year1950Challenge()
            case .hunter:
                HunterView()
            case .fireHose:
                FireHoseView(motionManager: MotionManager())
            case .year2025:
                Year2025Challenge()
            case .pollen:
                PollenView()
            case .year2100:
                Year2100View()
            }
        }
    }
}
