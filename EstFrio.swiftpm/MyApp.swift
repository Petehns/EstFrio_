import SwiftUI

@main
struct MyApp: App {
    init(){
            CustomFonts.register()
        }
    var body: some Scene {
        WindowGroup {
//            OnBoardScreen(showStartScreen: .constant(false))
//            StartScreen()
          MainView()
//            HoseChallenge()
        }
    }
}
