



import SwiftUI
import SceneKit
import CoreMotion

struct FireHoseView: UIViewRepresentable {
    @ObservedObject var motionManager: MotionManager = MotionManager()
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
 
    
    func makeUIView(context: UIViewRepresentableContext<FireHoseView>) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "hose2.scn")
        
        if let hose = sceneView.scene?.rootNode.childNode(withName: "hose2", recursively: true) {
         
            hose.eulerAngles = SCNVector3(0, Float.pi, 0)
            hose.position = SCNVector3(0, -100, -250)
            hose.scale = SCNVector3(1.5, 1.5, 1.5)
        }
        
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        
        challengeViewModel.completeFireHoseChallenge()
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<FireHoseView>) {
        guard let hose = uiView.scene?.rootNode.childNode(withName: "hose2", recursively: true) else { return }
        
      
        let sensitivity: Float = 2.5
        hose.eulerAngles = SCNVector3(0, Float(-motionManager.yaw) * sensitivity, 0)
    }
}

