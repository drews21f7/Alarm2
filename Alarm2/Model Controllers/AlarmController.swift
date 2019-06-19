//
//  AlarmController.swift
//  Alarm2
//
//  Created by Drew Seeholzer on 6/17/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController: AlarmScheduler{
    
    static let sharedInstance = AlarmController()
    
    var alarms = [Alarm]()
    
    
//    var mockAlarms:[Alarm] {
//        let alarm1 = Alarm(fireDate: , name: <#T##String#>)
//    }
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
        if alarm.enabled{
            scheduleUserNotification(for: alarm)
        } else {
            cancelUserNotification(for: alarm)
        }
    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        newAlarm.enabled = enabled
        AlarmController.sharedInstance.alarms.append(newAlarm)
        scheduleUserNotification(for: newAlarm)
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        
        cancelUserNotification(for: alarm)
        
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        
        scheduleUserNotification(for: alarm)
        
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        guard let index = AlarmController.sharedInstance.alarms.firstIndex(of: alarm) else { return }
        self.cancelUserNotification(for: alarm)
        alarms.remove(at: index)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store \(error) \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() -> [Alarm] {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            return alarms
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
        return []
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "Alarm2.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
}

protocol AlarmScheduler: class {
    func scheduleUserNotification(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotification(for alarm: Alarm) {
        
        let content = UNMutableNotificationContent()
        content.title = "Time to get up"
        content.body = "Your alarm named \(alarm.name) is going off!"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling local user notifications \(error.localizedDescription) : \(error)")
            }
        }
        
    }
    
    func cancelUserNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}
