//
//  Year2025Challenge.swift
//  EstFrio
//
//  Created by Pedro Henrique Nunes da Silveira Bezerra on 21/02/25.
//

import SwiftUI

struct Year2025Challenge: View {
    var body: some View {
        
      ZStack {
            Image("background2025")
              .resizable()
              .scaledToFill()
              .frame(width: UIScreen.main.bounds.width * 1.01, height: UIScreen.main.bounds.height * 1.01)
              .ignoresSafeArea()
          
          PollenView()
        }
    }
}
