//
//  TimeTtavelSlider.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct TimeTravelSlider: View {
    @State private var dragAngle: Double = 0       // Ângulo atual do slider
    @State private var previousDragAngle: Double = 0  // Guarda o ângulo anterior
    @State private var isMovingForward: Bool = true   // Determina se está indo para frente
    @State private var selectedYear: Int = 1950       // Ano selecionado no slider

    let years = [1950, 1975, 2025, 2075, 2100]  // Lista de anos disponíveis
    let images = [
        1950: "background1950",
        1975: "backgroundInt2",
        2025: "background2025",
        2075: "backgroundInt1",
        2100: "background2100"
    ]
    
    var body: some View {
        ZStack {
            // Fundo dinâmico conforme o ano selecionado
            Image(images[closestYear(to: dragAngle)] ?? "fallback_image")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                GeometryReader { geometry in
                    let width = geometry.size.width * 0.6
                    let radius: CGFloat = width / 3
                    
                    ZStack {
                        // Máscara semicircular
                        Image("semicircle_mask")
                            .resizable()
                            .scaledToFit()
                            .frame(width: width, height: radius * 2)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
                        // Exibir anos no semicirculo
                        ForEach(years, id: \.self) { year in
                            let angle = angleForYear(year)
                            let x = cos(angle) * (radius - 10)
                            let y = sin(angle) * (radius - 10)
                            
                            Text("\(year)")
                                .font(.caption)
                                .bold()
                                .foregroundColor(.white)
                                .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                        }
                        
                        // Nave espacial controlável
                        let x = cos(dragAngle) * radius
                        let y = sin(dragAngle) * radius
                        
                        Image(isMovingForward ? "timeTravelShip2" : "timeTravelShip1") // Alterna as imagens
                            .resizable()
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(adjustedRocketRotation(for: selectedYear))) // Inclina corretamente
                            .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let angle = angleFromLocation(value.location, in: geometry.size)

                                        // Atualiza a direção do movimento
                                        isMovingForward = angle > previousDragAngle
                                        
                                        dragAngle = angle
                                        selectedYear = closestYear(to: dragAngle)
                                        previousDragAngle = angle  // Atualiza o ângulo para a próxima comparação
                                    }
                            )
                    }
                }
                .frame(height: 120)
                
                Spacer()
            }
        }
    }
    
    // Define o ângulo correto para cada ano no slider
    func angleForYear(_ year: Int) -> Double {
        switch year {
        case 1950: return .pi
        case 1975: return 3 * .pi / 2.5
        case 2025: return -.pi / 2
        case 2075: return -.pi / 6
        case 2100: return 0
        default: return .pi / 45
        }
    }

    // Calcula o ângulo com base na posição do toque
    func angleFromLocation(_ location: CGPoint, in size: CGSize) -> Double {
        let dx = location.x - size.width / 2
        let dy = location.y - size.height / 2
        return atan2(dy, dx)
    }

    // Encontra o ano mais próximo do ângulo atual
    func closestYear(to angle: Double) -> Int {
        return years.min(by: { abs(angleForYear($0) - angle) < abs(angleForYear($1) - angle) }) ?? 1950
    }

    // Ajusta a rotação do foguete conforme o ano
    func adjustedRocketRotation(for year: Int) -> Double {
        let baseRotation = rocketRotationAngle(for: year) // Rotação normal
        
        return isMovingForward ? baseRotation : -baseRotation // Inverte a rotação quando volta
    }
    
    // Define a inclinação do foguete para cada ano
    func rocketRotationAngle(for year: Int) -> Double {
        switch year {
        case 1950: return -90
        case 1975: return -45
        case 2025: return 0
        case 2075: return 45
        case 2100: return 90
        default: return 0
        }
    }
}

struct SemiCircularSlider_Previews: PreviewProvider {
    static var previews: some View {
        TimeTravelSlider()
    }
}
