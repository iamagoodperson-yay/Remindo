//
//  homework.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 15/8/23.
//

import SwiftUI
import Combine

struct homework: View {
    
    @ObservedObject var homework = globalHW()
    
    @State private var error = false
    @State private var override = false
    @State private var showHw = false
        
    @State private var subj = ""
    @State private var what = ""
    @State private var duration = 0
    @State private var importance = 0
        
    var body: some View {
        NavigationStack {
                 
                List {
                    
//                    if (homework.hwShow[0].what != "") {
//
//                        Section {
//
//                            NavigationLink {
//                                homeworkShower()
//                            } label: {
//                                Text("View Timetable")
//                                    .foregroundColor(Color.white)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .buttonStyle(BorderlessButtonStyle())
//                            .padding(10)
//                            .background(eColor.lightBlue)
//                            .cornerRadius(10)
//
//                        }
//                    }
                    
                    Section {
                        
                        TextField("Subject", text: $subj)
                            .autocorrectionDisabled()
                        
                        TextField("Tasks", text: $what)
                            .autocorrectionDisabled()
                        
                        Stepper("Estimated duration (in minutes): \(duration)", value: $duration, in: 0...1440, step: 5)
                            .foregroundColor(Color.secondary)
                            .font(.system(size: 16))
                            .font(.caption)
                            .fontWeight(.regular)
                        
                        VStack(alignment: .leading) {
                            
                            Text("Importance:")
                                .foregroundColor(Color.secondary)
                                .font(.system(size: 16))
                                .font(.caption)
                                .fontWeight(.regular)
                            
                            HStack {
                                
                                Button {
                                    importance = 1
                                } label: {
                                    Text("Green")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(importance == 1 ? Color.gray : Color.green)
                                .cornerRadius(10)
                                
                                Spacer()
                                
                                Button {
                                    importance = 2
                                } label: {
                                    Text("Yellow")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(importance == 2 ? Color.gray : Color.yellow)
                                .cornerRadius(10)
                                
                                Spacer()
                                
                                Button {
                                    importance = 3
                                } label: {
                                    Text("Orange")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(importance == 3 ? Color.gray : Color.orange)
                                .cornerRadius(10)
                                
                                Spacer()
                                
                                Button {
                                    importance = 4
                                } label: {
                                    Text("Red")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(importance == 4 ? Color.gray : Color.red)
                                .cornerRadius(10)
                                
                            }
                            
                            Text("(Green is the least important, Red is the most)")
                                .foregroundColor(Color.secondary)
                                .font(.system(size: 15))
                                .font(.caption)
                                .fontWeight(.light)
                            
                        }
                        
                        VStack {
                            
                            HStack {
                                
                                Button {
                                    
                                    if (homework.hwInput[0].importance == 0) {
                                        homework.hwInput[0] = hw(subj: subj, what: what, duration: duration, importance: importance)
                                        subj = ""
                                        what = ""
                                        duration = 0
                                        importance = 0
                                        error = false
                                    } else if (subj == "" || what == "" || duration == 0 || importance == 0 ) {
                                        error = true
                                    } else {
                                        homework.hwInput.append(hw(subj: subj, what: what, duration: duration, importance: importance))
                                        subj = ""
                                        what = ""
                                        duration = 0
                                        importance = 0
                                        error = false
                                        homework.sortHw()
                                    }
                                    
                                    print(homework.hwInput)
                                    
                                } label: {
                                    Text("Save info")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(eColor.darkGreen)
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                                
                                
                                Button {
                                    subj = ""
                                    what = ""
                                    duration = 0
                                    importance = 0
                                    error = false
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(Color.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .padding(10)
                                .background(Color.red)
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                            if (error) {
                                Text("* ALL BLANKS MUST BE FILLED IN *")
                                    .foregroundColor(Color.red)
                                    .bold()
                                    .underline()
                            }
                            
                        }
                        
                        
                    } header: {
                        Text("Add your homework here:")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20, weight: .bold))
                            .textCase(.none)
                            .underline()
                            .padding(10)
                    }
                    
                    
                    Section {
                        
                        if (homework.hwInput[0].importance != 0) {
                            ForEach(homework.hwInput, id: \.id) {
                                hwIt in VStack(alignment: .leading) {
                                    
                                    Text(hwIt.subj)
                                        .font(.system(size: 25))
                                        .bold()
                                        .underline()
                                        .padding(10)
                                    
                                    Text("To do: \(hwIt.what)")
                                    
                                    Text("Estimated time: \(hwIt.duration)")
                                    
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .infinity
                                )
                                .foregroundColor(Color.white)
                                .background(
                                    hwIt.importance == 1 ? Color.green :
                                        hwIt.importance == 2 ? Color.yellow :
                                            hwIt.importance == 3 ? Color.orange :
                                                hwIt.importance == 4 ? Color.red :
                                                    Color.gray
                                )
                                
                            }.onDelete { indexSet in
                                if (homework.hwInput.count == 1) {
                                    homework.hwInput[0] = hw(subj: "", what: "", duration: 0, importance: 0)
                                } else {
                                    homework.hwInput.remove(atOffsets: indexSet)
                                }
                            }
                            
                        } else {
                            Text("No homework for now...")
                        }
                        
                    } header: {
                        Text("Entered homework:")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20))
                            .textCase(.none)
                            .bold()
                    } footer: {
                        Text("Swipe left to delete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    
                    
//                    Section {
//
//                        VStack {
//
//                            HStack {
//
//                                Text("How much time do you have: \(homework.timeAvaliable) minutes")
//                                    .multilineTextAlignment(.center)
//
//                                Image(systemName: "clock.arrow.circlepath")
//                            }
//
//                            Spacer
//                            Stepper("", value: $homework.timeAvaliable, in: 0...1440, step: 10)
//                                .foregroundColor(Color.secondary)
//                                .font(.system(size: 16))
//                                .font(.caption)
//                                .fontWeight(.regular)
//                            Spacer
//
//                        }
//
//                        Stepper("Number of breaks : \(homework.numBreak)", value: $homework.numBreak, in: 0...100)
//
//                        Stepper("Duration of breaks (in minutes) : \(homework.lengthBreak)", value: $homework.lengthBreak, in: 0...1440, step: 5)
//
//                    } header: {
//                        Text("Other information:")
//                            .foregroundColor(Color.white)
//                            .font(.system(size: 20))
//                            .textCase(.none)
//                            .bold()
//                    }
//
//                    Section {
//
//                        Button {
//                            override.toggle()
//                        } label: {
//                            Text("Generate Timetable")
//                                .foregroundColor(Color.white)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .buttonStyle(BorderlessButtonStyle())
//                        .padding(10)
//                        .background(eColor.lightBlue)
//                        .cornerRadius(10)
//                        .alert(isPresented:$override) {
//                            Alert(
//                                title: Text("Override Timetable"),
//                                message: Text("Are you sure you want to ovveride your previous timetable?"),
//                                primaryButton: .destructive(Text("Override")) {
//                                    print("Ovverride...")
//                                    homework.sortHw()
//                                    showHw.toggle()
//                                },
//                                secondaryButton: .cancel()
//                            )
//                        }
//
//                    }
                    
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
                    gradient: Gradient(colors: [Color.green, eColor.darkGreen]),
                    startPoint: .center,
                    endPoint: .bottom)
                )
                .scrollContentBackground(.hidden)

             }
        .environmentObject(homework)
        .sheet(isPresented: $showHw) {
            Remindo.homeworkShower()
        }
    }
}


struct homework_Previews: PreviewProvider {
    static var previews: some View {
        homework()
    }
}
