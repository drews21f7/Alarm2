//
//  Alarm.swift
//  Alarm2
//
//  Created by Drew Seeholzer on 6/17/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

class Alarm {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        return dateFormatter
    }
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
    }
}
