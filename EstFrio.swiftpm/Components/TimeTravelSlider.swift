//
//  TimeTtavelSlider.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 18/02/25.
//

import SwiftUI

struct TimeTravelSlider: View {
    @State private var dragAngle: Double = 0
    @State private var previousDragAngle: Double = 0
    @State private var isMovingForward: Bool = true
    @ObservedObject var appState = ChallengeViewModel.shared
        @State private var selectedYear: Int = 2100
    @State private var isGoingToDestination: Bool = false
    @State private var currentYear: Int = 1950
    let years = [1950, 1975, 2025, 2075, 2100]
    let availableYears : [Int] = [1950, 2025, 2100]
    let hiddenYears : [Int] = [1975, 2075]
    let images = [
        1950: "background1950",
        1975: "backgroundInt2",
        2025: "background2025",
        2075: "background2075",
        2100: "background2100"
    ]
    
    var body: some View {
      if !isGoingToDestination {
          ZStack {
              
              Image(images[closestYear(to: dragAngle)] ?? "fallback_image")
                  .resizable()
                  .scaledToFill()
                  .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                  .ignoresSafeArea(.all)
              
              VStack {
                  Spacer()
                  
                  GeometryReader { geometry in
                      let width = geometry.size.width * 0.6
                      let radius: CGFloat = width / 3
                      
                      ZStack {
                          
                          Image("semicircle_mask")
                              .resizable()
                              .scaledToFit()
                              .frame(width: width, height: radius * 2)
                              .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                          
                          
                          ForEach(years, id: \.self) { year in
                              let angle = angleForYear(year)
                              let x = cos(angle) * (radius - 10)
                              let y = sin(angle) * (radius - 10)
                              
                              if !hiddenYears.contains(year) {
                                  Text("\(year)")
                                      .font(.caption)
                                      .bold()
                                      .foregroundColor(.white)
                                      .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                              }
                              if !hiddenYears.contains(year) {
                                  Button(action: { /*isGoingToDestination = true */
                                      appState.travelToYear(Int(selectedYear))}) {
                                                 Text("Viajar no tempo")
                                                     .padding()
                                                     .background(Color.blue)
                                                     .foregroundColor(.white)
                                                     .cornerRadius(10)
                                             }
                                         }
                          }
                          
                          
                          let x = cos(dragAngle) * radius
                          let y = sin(dragAngle) * radius
                          
                          Image(isMovingForward ? "timeTravelShip2" : "timeTravelShip1")
                              .resizable()
                              .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.height * 0.035)
                              .rotationEffect(.degrees(adjustedRocketRotation(for: selectedYear)))
                              .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                              .gesture(
                                  DragGesture()
                                      .onChanged { value in
                                          let angle = angleFromLocation(value.location, in: geometry.size)
                                          print("valor", angle)
                                          
                                          
                                          isMovingForward = angle > previousDragAngle
                                          
                                          dragAngle = angle
                                          selectedYear = closestYear(to: dragAngle)
                                          previousDragAngle = angle
                                      }
                              )
                      }
                  }
                  .frame(height: 120)
                  
                  Spacer()
              }
              .padding(.top, UIScreen.main.bounds.height * 0.9)
          }
      }else{
          DestinationView(year: selectedYear)
      }
           
        
    }
    
 
    func angleForYear(_ year: Int) -> Double {
        switch year {
        case 1950: return .pi
        case 1975: return 5 * .pi / 4
        case 2025: return -.pi / 2
        case 2075: return -.pi / 6
        case 2100: return 0
        default: return .pi / 45
        }
    }

    
    func angleFromLocation(_ location: CGPoint, in size: CGSize) -> Double {
        let dx = location.x - size.width / 2
        let dy = location.y - size.height / 2
        return atan2(dy, dx)
    }

   
    func closestYear(to angle: Double) -> Int {
        return years.min(by: { abs(angleForYear($0) - angle) < abs(angleForYear($1) - angle) }) ?? 1950
    }


    func adjustedRocketRotation(for year: Int) -> Double {
        let baseRotation = rocketRotationAngle(for: year)
        
        return isMovingForward ? baseRotation : -baseRotation
    }
    

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
