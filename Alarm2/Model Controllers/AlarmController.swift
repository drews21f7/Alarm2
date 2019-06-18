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
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: Bool)
        alarms.append(newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms.remove(at: index)
    }
    
}
