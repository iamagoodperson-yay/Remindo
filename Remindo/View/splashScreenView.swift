//
//  splashScreenView.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 16/9/23.
//

import SwiftUI

struct splashScreenView: View {
        
    @State private var isActive = false
    @State private var size = 0.3
    @State private var opacity = 0.5

    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            
            VStack {
                VStack {
                    
                    Image("appicon")
                        .resizable()
                        .frame(width: 300, height: 300)
                    Text("Loading...")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(LinearGradient(
                            gradient: Gradient(colors: [eColor.darkGreen, Color.green]),
                            startPoint: .center,
                            endPoint: .bottom)
                        )
                    
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeInOut(duration: 1.5) .repeatCount(4,autoreverses: true)) {
                            self.size = 0.85
                            self.opacity = 0.75
                        }
                    }
                }
                
            }
            
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    withAnimation() {
                        self.isActive = true
                    }
                }
                
            }
            
        }
    }
}

struct splashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        splashScreenView()
    }
}
