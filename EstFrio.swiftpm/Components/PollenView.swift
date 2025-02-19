//
//  PollenView.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI
import AVFoundation

struct PollenView: View {
    @State private var isBlowing = false
    @State private var opacity: Double = 0.0
    @State private var currentIndex = 0
    @State private var wind = ["wind1", "wind2", "wind3", "wind4"]
    @State private var audioRecorder: AVAudioRecorder?
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
           Image("background2025")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth, height: screenHeight)

            // Animação do vento (quando o jogador sopra)
            if isBlowing {
                Image(wind[currentIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth, height: screenHeight)
                    .opacity(opacity)
            }
        }
        .onAppear {
            startAudioCapture()
isBlowing = true
            // Timer para alternar as imagens de vento a cada 0.8 segundos
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { _ in
                DispatchQueue.main.async {
                    if isBlowing {
                        currentIndex = (currentIndex + 1) % wind.count
                    }
                }
            }
        }
        .onDisappear {
            stopAudioCapture()
        }
        .onChange(of: isBlowing) { newValue in
            // Alterando a opacidade com animação quando o sopro é detectado
            withAnimation(.easeInOut(duration: 0.3)) {
                opacity = newValue ? 1.0 : 0.0
            }
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
        audioRecorder = nil  // Libere o recurso do áudio
    }
    
    // Função para verificar o nível de áudio e ativar o "sopro"
    @MainActor
    private func checkAudioLevels() {
        guard let recorder = audioRecorder else {
            print("Audio Recorder não está configurado.")
            return
        }
        
        recorder.updateMeters()
        
        // Verificar o nível de áudio (volume)
        let decibelLevel = recorder.averagePower(forChannel: 0)
        
        // Se o "sopro" for detectado, ativa o efeito de vento
        isBlowing = decibelLevel > -10
    }

    private func getAudioFileURL() -> URL {
        let tempDir = FileManager.default.temporaryDirectory
        return tempDir.appendingPathComponent("sopro.m4a")
    }
}

#Preview {
    PollenView()
}
