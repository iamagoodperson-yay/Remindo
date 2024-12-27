//
//  notificationHandler.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 15/9/23.
//

import Foundation
import UserNotifications

struct remind: Identifiable, Codable {
    var id = UUID().uuidString
    
    var subj: String
    var what: String
    var time: Date
    var importance: Int
    
}

class notification : ObservableObject {
    
    @Published var send = true { didSet { saveSend() } }
    @Published var reminds : [remind] { didSet { saveRemind() } }

    let reminderKey: String = "reminderKey"
    let sendKey: String = "sendKey"

    let defaultInput = UserDefaults.standard
    let defaultShow = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init() {
        
        var rem = [remind(subj: "", what: "", time: Date(), importance: 0)]
        var sen = true

        if let savedRem = defaultInput.object(forKey: reminderKey) as? Data {
            if let loadedRem = try? decoder.decode([remind].self, from: savedRem) {
                print("this is loaded reminders")
                print(loadedRem)
                rem = loadedRem
            }
        }
        self.reminds = rem
        
        if let savedSend = defaultInput.object(forKey: reminderKey) as? Data {
            if let loadedSend = try? decoder.decode(Bool.self, from: savedSend) {
                print("this is loaded reminders")
                print(loadedSend)
                sen = loadedSend
            }
        }
        self.send = sen

    }

    func saveRemind() {
        if let encoded = try? encoder.encode(reminds) {
            defaultInput.set(encoded, forKey: reminderKey)
        }
    }
    
    func saveSend() {
        if let encoded = try? encoder.encode(send) {
            defaultInput.set(encoded, forKey: sendKey)
        }
    }
    
    func sortRemind() {
        reminds.sort{
            $0.time < $1.time
        }
        print("Sorted (i hope)")
        print(reminds)
    }
    
    func askPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
            
        } )
    }
    
    func sendNotification(index: Int) {
        
        print("sendNotification")
        
        if send {
            let noti = reminds[index]
            
            var trigger : UNNotificationTrigger?
            var impt = ""
            var identifier = ""
            
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: noti.time)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            print("date components, trigger")
            
            if noti.importance == 4 { impt = "🟥🟥🟥 " + noti.subj + " 🟥🟥🟥" }
            else if noti.importance == 3 { impt = "🟧🟧🟧 " + noti.subj + " 🟧🟧🟧" }
            else if noti.importance == 2 { impt = "🟨🟨🟨 " + noti.subj + " 🟨🟨🟨" }
            else if noti.importance == 1 { impt = "🟩🟩🟩 " + noti.subj + " 🟩🟩🟩" }
            
            let content = UNMutableNotificationContent()
            content.title = impt
            content.body = noti.what
            content.sound = UNNotificationSound.default
            print("content")
            
            identifier = noti.id
            
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            print("request")
            
        }
        
    }
    
    func removeNotification(index: Int) {
        let noti = reminds[index]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [noti.id])
    }
    
    func removeAllNotifications() {
        for noti in reminds {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [noti.id])
        }
    }
    
}
