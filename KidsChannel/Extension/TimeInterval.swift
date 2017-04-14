//
//  NSTimeInterval.swift
//  KidsChannel
//
//  Created by InkaMacAir on 2017. 4. 8..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func string() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
