//
//  FireHoseChallenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 22/02/25.
//
import SwiftUI
struct FireHoseChallenge: View {
    let fireImages: [String] = ["fire1", "fire2", "fire3", "fire4"]
    @State private var currentIndex = 0
    @State private var opacity = 1.0
    @State private var randomOffsets: [CGSize] = []
    @State private var randomDelays: [Double] = []
    
    var body: some View {
        ZStack {
            Image("background1950")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                .ignoresSafeArea()
            
            ZStack {
              
                Image("fire1")
                       .resizable()
                       .scaledToFit()
                       .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
                       .opacity(opacity)
                       .animation(.linear(duration: 1.0), value: opacity)
                  
                
            
                
            }
           
            
            ZStack{
                Rectangle()
                    .foregroundStyle(Color("yellowEstFrio"))
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.1)
                    .cornerRadius(20)
                Text("Tilt the device to turn the hose")
                    .font(.custom(.font, size: 25))
                    .foregroundStyle(Color("redEstFrio"))
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.8)
           
            FireHoseView()
            
        }
    }
}
