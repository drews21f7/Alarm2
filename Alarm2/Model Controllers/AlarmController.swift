//
//  AlarmController.swift
//  Alarm2
//
//  Created by Drew Seeholzer on 6/17/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
//    var mockAlarms:[Alarm] {
//        let alarm1 = Alarm(fireDate: , name: <#T##String#>)
//    }
    
    func addAlarm(fireDate: Date, name: String) {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        alarms.append(newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String) {
        alarm.fireDate = fireDate
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
}
