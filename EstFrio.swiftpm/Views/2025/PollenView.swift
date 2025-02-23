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
            
            ZStack{
                Rectangle()
                    .foregroundStyle(Color("yellowEstFrio"))
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.1)
                    .cornerRadius(20)
                Text("Blow on the mic to spread the pollen")
                    .font(.custom(.font, size: 25))
                    .foregroundStyle(Color("redEstFrio"))
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.8)
            
            if isBlowing {
                Image(wind[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth, height: screenHeight)
                    .opacity(opacity)
            }
            
            ForEach(polens) { pollen in
                Circle()
                    .fill(Color.yellow.opacity(pollen.opacity))
                    .frame(width: 8, height: 8)
                    .position(pollen.position)
                    .onAppear {
                        animatePollen(pollen.id)
                    }
            }
        }
        .onAppear {
            startAudioCapture() // Inicia a captura de áudio quando a view aparece
        }
        .onDisappear {
            stopAudioCapture() // Para a captura de áudio quando a view desaparecer
        }
        .onChange(of: isBlowing) { newValue in
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = newValue ? 1.0 : 0.0
            }
            
            if newValue {
                generatePollen() // Gera o pólen quando o usuário começa a soprar
            }
        }
        .onAppear {
            challengeViewModel.completePollenChallenge()
        }
    }
    
    private func generatePollen() {
        for _ in 0..<20 {
            let startX = CGFloat.random(in: 0...screenWidth)
            let startY = CGFloat.random(in: screenHeight * 0.7...screenHeight) // Posição inicial do pólen

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
    
    private func animatePollen(_ id: UUID) {
        guard let index = polens.firstIndex(where: { $0.id == id }) else { return }
        
        let randomX = CGFloat.random(in: -50...50)
        let randomY = CGFloat.random(in: -100 ... -30) // Movimento aleatório para o pólen
        
        withAnimation(.linear(duration: 0.5)) {
            polens[index].position.x += randomX
            polens[index].position.y += randomY
        }
        
        // Animar novamente após 0.5 segundos para simular um movimento contínuo
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animatePollen(id)
        }
    }
    
    // Funções de captura de áudio
    private func startAudioCapture() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Configuração da sessão de áudio para captura
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            // Criação do gravador de áudio
            audioRecorder = try AVAudioRecorder(url: getAudioFileURL(), settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            
            // Iniciar um timer para monitorar os níveis de áudio a cada 0.1 segundos
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                Task { @MainActor in
                    self.checkAudioLevels() // Verifica se há sopro
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
    
    @MainActor
    private func checkAudioLevels() {
        guard let recorder = audioRecorder else {
            print("Audio Recorder não está configurado.")
            return
        }
        
        recorder.updateMeters()
        
        // Verificar o nível de áudio (volume)
        let decibelLevel = recorder.averagePower(forChannel: 0)
        
        // Ativar a animação de "sopro" se o nível de áudio for maior que -10 dB
        isBlowing = decibelLevel > -10
    }
    
    private func getAudioFileURL() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        return tempDir.appendingPathComponent("sopro.m4a")
    }
}

struct PollenParticle: Identifiable {
    let id: UUID
    var position: CGPoint
    var opacity: Double
}

#Preview {
    PollenView()
}
