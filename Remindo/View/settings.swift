//
//  settings.swift
//  innofest app
//
//  Created by Kenzie Vimalaputta Irawan on 15/8/23.
//

import SwiftUI

struct settings: View {
    
    @ObservedObject var notify = notification()
    
//    @State var hwNoti = true
//    @State var remindNoti = true
//    @State private var tempHwNoti = true
//    @State private var tempRemindNoti = true
        
    @State private var temp = ""
    @State private var done = false
    @Binding var username: String
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    
                    Toggle(
                        isOn: $notify.send,
                        label: {
                            HStack {
                                
                                Text("All notifications?")
                                
                                Image(systemName: "exclamationmark.bubble")
                                
                            }
                    })
                    .onChange(of: notify.send) { notif in
                        if (!notif) {
                            notify.removeAllNotifications()
                        }
                    }
                    
                    Button {
                        notify.askPermissions()
                    } label: {
                        Text("Allow notification permissions:")
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(10)
                    .background(eColor.darkBlue)
                    .cornerRadius(10)
                    
//                    if (notifications) {
//
//                            Toggle(
//                                isOn: $hwNoti,
//                                label: {
//                                    HStack {
//
//                                        Text("Homework?")
//
//                                        Image(systemName: "doc.text")
//
//                                    }
//                                }).onAppear {
//                                    hwNoti = tempHwNoti
//                                }.onDisappear() {
//                                    tempHwNoti = hwNoti
//                                    hwNoti = false
//                                }
//
//                        Toggle(
//                            isOn: $remindNoti,
//                            label: {
//                                HStack {
//
//                                    Text("Reminders?")
//
//                                    Image(systemName: "captions.bubble")
//
//                                }
//                            }).onAppear {
//                                remindNoti = tempRemindNoti
//                            }.onDisappear() {
//                                tempRemindNoti = remindNoti
//                                remindNoti = false
//                            }
//
//                    }
                    
                } header: {
                    Text("Notifications")
                        .foregroundColor(Color.white)
                        .font(.system(.callout))
                }
                
                Section {
                    
                    VStack {
                        
                        Text("What is your username?")
                        
                        
                        TextField("Username", text: $temp)
                            .autocorrectionDisabled()
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 10)
                            .textFieldStyle(.roundedBorder)
                        
                        HStack {
                            
                            Button {
                                username = temp
                                done = true
                                print(done)
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
                                temp = ""
                                username = ""
                                done = false
                            } label: {
                                Text("Erase info")
                                    .foregroundColor(Color.white)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                            
                        }
                        
                        if (done) {
                            Text("Saved! Your username is now \(username)")
                                .padding(.top, 10)
                        }
                        
                    }
                    
                } header: {
                    Text("greeting (optional)")
                        .foregroundColor(Color.white)
                        .font(.system(.callout))
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                }
            }
            .toolbarBackground(eColor.lightBlue, for: .navigationBar)
            
            .background(eColor.lightBlue)
            .scrollContentBackground(.hidden)
            
            NavigationLink { ContentView() } label: {}
            
            .environmentObject(notify)
        }
    }
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        settings(username: .constant("Placeholder"))
    }
}
