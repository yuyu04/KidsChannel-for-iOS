//
//  Array.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 13..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

extension Array {
    func slice(from value: (start: Int, last: Int)) -> Array? {
        let last = (value.last > self.count) ? self.count : value.last
        if last <= value.start {
            return nil
        }
        return Array(self[value.start..<last])
    }
}
