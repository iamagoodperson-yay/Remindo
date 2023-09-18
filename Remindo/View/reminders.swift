//
//  reminders.swift
//  innofest app
//
//  Created by Kenzie Vimalaputta Irawan on 15/8/23.
//

import SwiftUI

struct reminders: View {
    
    @ObservedObject var notify = notification()
    
    @State private var title = ""
    @State private var what = ""
    @State private var time = Date()
    @State private var importance = 0
    
    @State private var error = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            
            List {
                
                Section {
                    
                    TextField("Title", text: $title)
                        .autocorrectionDisabled()
                    
                    TextField("Specifics", text: $what)
                        .autocorrectionDisabled()
                    
                    DatePicker("Time of reminder", selection: $time, in: Date.now...)
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
                                
                                if (notify.reminds[0].importance == 0) {
                                    notify.reminds[0] = remind(subj: title, what: what, time: time, importance: importance)
                                    error = false
                                    notify.sendNotification(index: 0)
                                } else if (title == "" || what == "" || time == Date() || importance == 0 ) {
                                    error = true
                                } else {
                                    let indexNum = notify.reminds.count
                                    notify.reminds.append(remind(subj: title, what: what, time: time, importance: importance))
                                    notify.sendNotification(index: indexNum)
                                    error = false
                                    notify.sortRemind()
                                }
                                
                                print(notify.reminds)
                                if (error == false) {
                                    print("notification sent!")
                                    title = ""
                                    what = ""
                                    time = Date()
                                    importance = 0
                                }
                                    
                                
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
                                
                                title = ""
                                what = ""
                                time = Date()
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
                    Text("Make new reminder:")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .textCase(.none)
                        .bold()
                }
                
                Section {
                    
                    if (notify.reminds[0].importance != 0) {
                        ForEach(notify.reminds, id: \.id) {
                            remIt in VStack(alignment: .leading) {
                                
                                Text(remIt.subj)
                                    .font(.system(size: 25))
                                    .bold()
                                    .underline()
                                    .padding(10)
                                
                                Text("To do: \(remIt.what)")
                                
                                Text("Date and time of reminder:")
                                Text(dateFormatter.string(from: remIt.time))
                                
                            }
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity
                            )
                            .foregroundColor(Color.white)
                            .background(
                                remIt.importance == 1 ? Color.green :
                                    remIt.importance == 2 ? Color.yellow :
                                        remIt.importance == 3 ? Color.orange :
                                            remIt.importance == 4 ? Color.red :
                                                Color.gray
                            )
                            
                        }.onDelete { indexSet in
                            if (notify.reminds.count == 1) {
                                notify.reminds[0] = remind(subj: "", what: "", time: Date(), importance: 0)
                                notify.removeNotification(index: 0)
                            } else {
                                let index = indexSet[indexSet.startIndex]
                                notify.removeNotification(index: index)
                                notify.reminds.remove(atOffsets: indexSet)
                            }
                        }
                        
                    } else {
                        Text("No reminders for now...")
                    }
                    
                } header: {
                    Text("Entered Reminders:")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20))
                        .textCase(.none)
                        .bold()
                } footer: {
                    Text("Swipe right to delete")
                        .foregroundColor(Color.white)
                        .bold()
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Reminders")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                }
            }
            .toolbarBackground(eColor.darkBlue, for: .navigationBar)
        
            .background(LinearGradient(
                gradient: Gradient(colors: [eColor.darkBlue, eColor.lightBlue]),
                startPoint: .center,
                endPoint: .bottom)
            )
            .scrollContentBackground(.hidden)
            
            .environmentObject(notify)
        }
    }
}

struct reminders_Previews: PreviewProvider {
    static var previews: some View {
        reminders()
    }
}
