import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        FireHoseView(motionManager: motionManager)
            .edgesIgnoringSafeArea(.all)
    }
}

