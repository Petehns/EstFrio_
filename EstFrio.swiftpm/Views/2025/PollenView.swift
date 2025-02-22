//
//  PollenView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI
import AVFoundation

struct PollenView: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    @State private var isBlowing = false
    @State private var opacity: Double = 0.0
    @State private var currentIndex = 0
    @State private var wind = ["wind1", "wind2", "wind3", "wind4"]
    @State private var audioRecorder: AVAudioRecorder?
    @State private var isShowingFire = false
    @State private var polens: [PollenParticle] = []
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
     
                    ZStack {
                        Image("background2025")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                            .ignoresSafeArea()
                        
                        if isBlowing {
                            Image(wind[currentIndex])
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth, height: screenHeight)
                                .opacity(opacity)
                        }
                        
                        // Partículas de pólen voando continuamente
                        ForEach(polens) { pollen in
                            Circle()
                                .fill(Color.yellow.opacity(pollen.opacity))
                                .frame(width: 8, height: 8)
                                .position(pollen.position)
                                .onAppear {
                                    animatePollen(pollen.id)
                                }
                      
                    .onAppear {
                        startAudioCapture()
                    }
                    .onDisappear {
                        stopAudioCapture()
                    }
                    .onChange(of: isBlowing) { newValue in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            opacity = newValue ? 1.0 : 0.0
                        }
                        
                        if newValue {
                            generatePollen()
                        }
                    }
                }
            
        
        }
        .onAppear{
            challengeViewModel.completePollenChallenge()
        }
    }
    
    // Função para gerar pólens animados
    private func generatePollen() {
        for _ in 0..<50 { // Aumentei o número de partículas para 20
            let startX = CGFloat.random(in: 0...screenWidth) // Posições horizontais agora vão de 0 até a largura da tela
            let startY = CGFloat.random(in: screenHeight * 0.7...screenHeight) // Posições verticais agora são mais distribuídas pela parte inferior
            
            let newPollen = PollenParticle(
                id: UUID(),
                position: CGPoint(x: startX, y: startY),
                opacity: 1.0
            )
            
            polens.append(newPollen)
            animatePollen(newPollen.id)
            
            // Remover após 5 segundos
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.easeOut(duration: 1)) {
                    if let index = polens.firstIndex(where: { $0.id == newPollen.id }) {
                        polens[index].opacity = 0.0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    polens.removeAll { $0.opacity == 0.0 }
                }
            }
        }
    }
    
    
    // Função para animar cada pólen continuamente
    private func animatePollen(_ id: UUID) {
        guard let index = polens.firstIndex(where: { $0.id == id }) else { return }
        
        let randomX = CGFloat.random(in: -50...50)
        let randomY = CGFloat.random(in: -100 ... -30)
        
        
        
        withAnimation(.linear(duration: 0.5)) {
            polens[index].position.x += randomX
            polens[index].position.y += randomY
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animatePollen(id) // Continua movendo até desaparecer
        }
    }
    
    // Funções de captura de áudio
    private func startAudioCapture() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: getAudioFileURL(), settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            
            // Iniciar um timer para verificar os níveis de áudio periodicamente
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                Task { @MainActor in
                    self.checkAudioLevels()
                }
            }
        } catch {
            print("Erro ao configurar o áudio: \(error)")
        }
    }
    
    private func stopAudioCapture() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
    
    // Função para verificar o nível de áudio e ativar o "sopro"
    @MainActor
    private func checkAudioLevels() {
        guard let recorder = audioRecorder else {
            print("Audio Recorder não está configurado.")
            return
        }
        
        recorder.updateMeters()
        
        // Agora o microfone está mais sensível (-20 dB ao invés de -10 dB)
        let decibelLevel = recorder.averagePower(forChannel: 0)
        isBlowing = decibelLevel > -20
    }
    
    private func getAudioFileURL() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        return tempDir.appendingPathComponent("sopro.m4a")
    }
}

// Modelo para representar cada partícula de pólen
struct PollenParticle: Identifiable {
    let id: UUID
    var position: CGPoint
    var opacity: Double
}

#Preview {
    PollenView()
}
