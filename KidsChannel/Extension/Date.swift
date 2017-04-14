//
//  Date.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 12..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSice1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
