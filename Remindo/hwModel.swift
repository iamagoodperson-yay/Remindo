//
//  hwModel.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 29/8/23.
//

import Foundation

struct hw: Identifiable, Codable {
    var id = UUID()
    
    var subj: String
    var what: String
    var duration: Int
    var importance: Int
    
}

class globalHW: ObservableObject {

    @Published var hwInput : [hw] { didSet { saveIn() } }
//    @Published var hwShow : [hw] { didSet { saveShow() } }
//    @Published var timeAvaliable : Int { didSet { saveMisc() } }
//    @Published var numBreak : Int { didSet { saveMisc() } }
//    @Published var lengthBreak : Int { didSet { saveMisc() } }

    let hwInputKey: String = "hwInputKey"
//    let hwShowKey: String = "hwShowKey"
//    let timeAvaliableKey: String = "timeAvaliableKey"
//    let numBreakKey: String = "numBreakKey"
//    let lengthBreakKey: String = "lengthBreakKey"

    let defaultInput = UserDefaults.standard
    let defaultShow = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init() {
        
        var In: [hw] = [hw(subj: "", what: "", duration: 0, importance: 0)]
//        var Show: [hw] = [hw(subj: "", what: "", duration: 0, importance: 0)]
//        var time = 0
//        var num = 0
//        var length = 0

        if let savedInput = defaultInput.object(forKey: hwInputKey) as? Data {
            if let lodadedInput = try? decoder.decode([hw].self, from: savedInput) {
                print("this is loaded input")
                print(lodadedInput)
                In = lodadedInput
            }
        }
        self.hwInput = In
        
//        if let savedShow = defaultInput.object(forKey: hwShowKey) as? Data {
//            if let loadedShow = try? decoder.decode([hw].self, from: savedShow) {
//                print("this is loaded show")
//                print(loadedShow)
//                Show = loadedShow
//            }
//        }
//        self.hwShow = Show
//
//        if let savedTime = defaultInput.object(forKey: hwShowKey) as? Data {
//            if let loadedTime = try? decoder.decode(Int.self, from: savedTime) {
//                print("this is loaded time")
//                print(loadedTime)
//                time = loadedTime
//            }
//        }
//        self.timeAvaliable = time
//
//        if let savedNum = defaultInput.object(forKey: hwShowKey) as? Data {
//            if let loadedNum = try? decoder.decode(Int.self, from: savedNum) {
//                print("this is loaded num")
//                print(loadedNum)
//                num = loadedNum
//            }
//        }
//        self.numBreak = num
//
//        if let savedLength = defaultInput.object(forKey: hwShowKey) as? Data {
//            if let loadedLength = try? decoder.decode(Int.self, from: savedLength) {
//                print("this is loaded show")
//                print(loadedLength)
//                length = loadedLength
//            }
//        }
//        self.lengthBreak = length

    }

    func saveIn() {
        if let encoded = try? encoder.encode(hwInput) {
            defaultInput.set(encoded, forKey: hwInputKey)
        }
    }

//    func saveShow() {
//        if let encoded = try? encoder.encode(hwShow) {
//            defaultShow.set(encoded, forKey: hwShowKey)
//        }
//    }
//    
//    func saveMisc() {
//        
//        if let encoded = try? encoder.encode(timeAvaliable) {
//            defaultShow.set(encoded, forKey: timeAvaliableKey)
//        }
//        
//        if let encoded = try? encoder.encode(numBreak) {
//            defaultShow.set(encoded, forKey: numBreakKey)
//        }
//        
//        if let encoded = try? encoder.encode(lengthBreak) {
//            defaultShow.set(encoded, forKey: lengthBreakKey)
//        }
//        
//    }
    
    func sortHw() {
        hwInput.sort{
            $0.importance > $1.importance
        }
        print("Sorted (i hope)")
        print(hwInput)
    }

}
