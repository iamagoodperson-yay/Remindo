//
//  ContentView.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 11/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("greetingKey") var username = ""
    @State private var settings = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if (username != "") {
                    Text("Hello, \(username) !")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .underline()
                        .bold()
                        .padding()
                }
            
                NavigationLink{
                    homework()
                } label: {
                    
                    Text("Homework")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50, weight: .bold))
                        .frame(
                            width: 340,
                            height: 300
                        )
                    
                }
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color.green, eColor.darkGreen]),
                    startPoint: .center,
                    endPoint: .bottom)
                )
                .cornerRadius(50)
                .shadow(
                    color: Color(red: 0.6, green: 0.75, blue: 0.65),
                    radius: 10,
                    x: 5,
                    y: 7.5
                )
                .padding(.bottom, 50)
                
                NavigationLink{
                    reminders()
                } label: {
                    
                    Text("Reminders")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50, weight: .bold))
                        .frame(
                            width: 340,
                            height: 300
                        )

                }
                .background(LinearGradient(
                    gradient: Gradient(colors: [eColor.darkBlue, eColor.lightBlue]),
                    startPoint: .center,
                    endPoint: .bottom)
                )
                
                .cornerRadius(50)
                .shadow(
                    color: Color(red: 0.6, green: 0.65, blue: 0.75),
                    radius: 10,
                    x: 5,
                    y: 7.5
                )
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Image("appicon")
                        .resizable()
                        .frame(
                            width: 35,
                            height: 35
                        )
                    
                }
                
                ToolbarItem(placement: .principal) {
                    
                    Text("Remindo") 
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(LinearGradient(
                            gradient: Gradient(colors: [eColor.darkGreen, Color.green]),
                            startPoint: .center,
                            endPoint: .bottom)
                        )
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        settings.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color.black)
                            .font(.system(size: 35))
                    }
                    
                    
                }

            }
            
            .sheet(isPresented: $settings) {
                Remindo.settings(username: $username)
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
