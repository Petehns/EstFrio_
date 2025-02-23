import SwiftUI
import SceneKit
import CoreMotion

struct FireHoseView: UIViewRepresentable {
    @ObservedObject var motionManager: MotionManager = MotionManager()
    @EnvironmentObject var challengeViewModel: ChallengeViewModel

    func makeUIView(context: UIViewRepresentableContext<FireHoseView>) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene(named: "hose2.scn")!
        sceneView.scene = scene

        if let hose = scene.rootNode.childNode(withName: "hose2", recursively: true) {
            hose.eulerAngles = SCNVector3(0, Float.pi, 0)
            hose.position = SCNVector3(0, -100, -250)
            hose.scale = SCNVector3(1.5, 1.5, 1.5)

            // 💦 Adiciona a partícula de água na ponta da mangueira
            let water = createWaterParticle()
            hose.addChildNode(water)
        }

        // 🔥 Adiciona fogo na cena
        let fire = createFireParticle()
        scene.rootNode.addChildNode(fire)

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

        // 🚨 Verifica se a água atingiu o fogo
        if let water = hose.childNode(withName: "water", recursively: true),
           let fire = uiView.scene?.rootNode.childNode(withName: "fire", recursively: true) {
            if water.presentation.worldPosition.distance(to: fire.presentation.worldPosition) < 50 {
                fire.removeFromParentNode() // 🔥 Apaga o fogo
            }
        }
    }

    func createWaterParticle() -> SCNNode {
        // Use o Bundle.module para acessar o recurso dentro do pacote SwiftPM
        guard let water = SCNParticleSystem(named: "Water.sks", inDirectory: Bundle.module.resourcePath) else {
            print("Falha ao carregar a partícula de água.")
            return SCNNode()
        }
        let waterNode = SCNNode()
        waterNode.name = "water"
        waterNode.position = SCNVector3(0, 0, -5) // Sai da ponta da mangueira
        waterNode.addParticleSystem(water)
        return waterNode
    }


    /// 🔥 Cria o sistema de partículas do fogo
    func createFireParticle() -> SCNNode {
        guard let fire = SCNParticleSystem(named: "Fire.sks", inDirectory: Bundle.main.resourcePath) else {
            print("Falha ao carregar a partícula de fogo.")
            return SCNNode()
        }
        let fireNode = SCNNode()
        fireNode.name = "fire"
        fireNode.position = SCNVector3(0, -50, -100) // Ajuste conforme necessário
        fireNode.addParticleSystem(fire)
        print("Partícula de fogo carregada com sucesso!")  // Depuração
        return fireNode
    }
}

// 🔄 Calcula a distância entre dois pontos no mundo 3D
extension SCNVector3 {
    func distance(to vector: SCNVector3) -> Float {
        let dx = self.x - vector.x
        let dy = self.y - vector.y
        let dz = self.z - vector.z
        return sqrt(dx * dx + dy * dy + dz * dz)
    }
}



/*
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
*/
