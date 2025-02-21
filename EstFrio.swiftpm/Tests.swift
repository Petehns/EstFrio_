////
////  Tests.swift
////  EstFrio
////
////  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
////
//
//import SwiftUI
//import SceneKit
//import CoreMotion
//
//// Gerenciador de Movimento
//class MotionManager: ObservableObject {
//    private var motion = CMMotionManager()
//    @Published var pitch: Double = 0.0
//    @Published var yaw: Double = 0.0
//    
//    init() {
//        motion.deviceMotionUpdateInterval = 1 / 60
//        motion.startDeviceMotionUpdates(to: .main) { (data, error) in
//            if let data = data {
//                self.pitch = data.attitude.pitch
//                self.yaw = data.attitude.yaw
//            }
//        }
//    }
//}
//
//// View Representável para a Mangueira 3D
//struct FireHoseView: UIViewRepresentable {
//    @ObservedObject var motionManager: MotionManager
//
//    func makeUIView(context: UIViewRepresentableContext<FireHoseView>) -> SCNView {
//        let sceneView = SCNView()
//        sceneView.scene = SCNScene(named: "hose2.scn")
//        
//        if let hose = sceneView.scene?.rootNode.childNode(withName: "hose2", recursively: true) {
//            hose.eulerAngles = SCNVector3(0, Float.pi, 0)
//            hose.position = SCNVector3(0, -100, -250)
//            hose.scale = SCNVector3(1.5, 1.5, 1.5)
//        }
//        
//        sceneView.allowsCameraControl = false
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.backgroundColor = .clear
//        
//        return sceneView
//    }
//
//    func updateUIView(_ uiView: SCNView, context: UIViewRepresentableContext<FireHoseView>) {
//        guard let hose = uiView.scene?.rootNode.childNode(withName: "hose2", recursively: true) else { return }
//        
//        let sensitivity: Float = 2.5
//        hose.eulerAngles = SCNVector3(
//            Float(motionManager.pitch) * sensitivity, // Movimento vertical
//            Float(-motionManager.yaw) * sensitivity,  // Movimento horizontal
//            0
//        )
//    }
//}
//
//// View Principal do Jogo
//struct FireHoseGameView: View {
//    @StateObject private var motionManager = MotionManager()
//    @State private var firePositions: [CGPoint] = [
//        CGPoint(x: 100, y: 300),
//        CGPoint(x: 200, y: 400),
//        CGPoint(x: 300, y: 250)
//    ]
//    
//    @State private var isShooting = false
//
//    var body: some View {
//        ZStack {
//            Color.black.edgesIgnoringSafeArea(.all)
//
//            // Exibir fogos
//            ForEach(firePositions, id: \.self) { position in
//                Image(systemName: "flame.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(.red)
//                    .position(position)
//            }
//
//            // Mangueira 3D (controlada pelo giroscópio)
//            FireHoseView(motionManager: motionManager)
//                .frame(width: 300, height: 300)
//                .position(x: 200, y: 600)
//
//            // Efeito de água
//            if isShooting {
//                Circle()
//                    .frame(width: 10, height: 10)
//                    .foregroundStyle(.blue)
//                    .position(x: 200, y: 550)
//                    .particleEffect(
//                        .image("drop.fill"),
//                        system: .rain,
//                        status: .active
//                    )
//            }
//        }
//        .onAppear {
//            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                detectFireCollision()
//            }
//        }
//        .onTapGesture {
//            isShooting.toggle()
//        }
//    }
//
//    // Detectar se a água atingiu os fogos
//    func detectFireCollision() {
//        if isShooting {
//            firePositions.removeAll { fire in
//                let distance = hypot(200 - fire.x, 550 - fire.y)
//                return distance < 50
//            }
//        }
//    }
//}
//
//// Preview
//struct FireHoseGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        FireHoseGameView()
//    }
//}
