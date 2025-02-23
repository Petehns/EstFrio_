//
//  Year2025Challenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

struct Year2025Challenge: View {
    @EnvironmentObject var challengeViewModel: ChallengeViewModel
    @State var start2025Challenge: Bool = false
    var body: some View {
        
      ZStack {
            Image("background2025")
              .resizable()
              .scaledToFill()
              .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
              .ignoresSafeArea()
          if !start2025Challenge {
              HStack {
                  Image("michelleSad")
                      .resizable()
                      .scaledToFill()
                      .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.35)
                      .padding(.top, UIScreen.main.bounds.height * 0.6)
                      .padding(.leading, UIScreen.main.bounds.width * 0.07)
                  ZStack {
                      Image("speechBaloon")
                          .resizable()
                          .scaledToFit()
                          .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.7)
                      
                      Text("The landscape is a mix of destruction and hope. 80% of the Atlantic Forest has been lost, but reforestation efforts are emerging.\nHelp spread the pollen so new trees can grow!")
                          .font(.custom(.font, size: 22))
                          .foregroundStyle(Color("greenEstFrio"))
                          .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.3)
                          .padding(.trailing, UIScreen.main.bounds.width * 0.16)
                      Button(action:{

                          start2025Challenge.toggle()
                      }, label: {
                          ZStack{
                              Rectangle()
                                  .foregroundStyle(Color("redEstFrio"))
                                  .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.height * 0.07)
                                  .cornerRadius(20)
                              Text("Start challenge")
                                  .font(.custom(.font, size: 22))
                                  .foregroundStyle(.white)
                          }
                      })
                      .padding(.top, UIScreen.main.bounds.height * 0.135)
                      .padding(.leading, UIScreen.main.bounds.width * 0.51)
                      
                  }
                  
                  .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.3)
                  .padding(.leading, UIScreen.main.bounds.width * 0.12)
                  .padding(.top, UIScreen.main.bounds.height * 0.7)
                  .padding(.trailing, UIScreen.main.bounds.width * 0.29)
              }
                         
                    
          }else{
              PollenView()
          }
        }
    }
}
