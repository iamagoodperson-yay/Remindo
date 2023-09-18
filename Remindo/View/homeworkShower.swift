//
//  homeworkShower.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 21/8/23.
//

import SwiftUI

struct homeworkShower: View {
    
    @EnvironmentObject var homework: globalHW
        
    var body: some View {
        
        List {
            
            Section {
                Text("Hello world!")
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Homework")
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .bold()
            }
        }
        .toolbarBackground(Color.green, for: .navigationBar)
  
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.green, eColor.darkBlue]),
            startPoint: .center,
            endPoint: .bottom)
        )
        .scrollContentBackground(.hidden)
        
    }
}

struct homeworkShower_Previews: PreviewProvider {
    static var previews: some View {
        homeworkShower()
    }
}
