import SwiftUI
import SceneKit
import CoreMotion

struct FireHoseView: UIViewRepresentable {
    @ObservedObject var motionManager: MotionManager
    
    func makeUIView(context: UIViewRepresentableContext<FireHoseView>) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "hose.scn")

        if let hose = sceneView.scene?.rootNode.childNode(withName: "hose", recursively: true) {
            hose.scale = SCNVector3(x: -1, y: -1, z: -1)
            
            hose.rotation = SCNVector4(0, 0, 0, 1)
            hose.position = SCNVector3(x: 600, y: -100, z: -20)
        }

        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        
        return sceneView
    }
   
    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<FireHoseView>) {
        guard let hose = uiView.scene?.rootNode.childNode(withName: "hose", recursively: true) else { return }

    
        let rotationX = SCNMatrix4MakeRotation(Float(motionManager.pitch), 1, 0, 0)
        let rotationY = SCNMatrix4MakeRotation(Float(motionManager.roll), 0, 1, 0)


        let combinedRotation = SCNMatrix4Mult(rotationX, rotationY)
        
        hose.transform = combinedRotation
    }
}
