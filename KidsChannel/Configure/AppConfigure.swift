//
//  AppConfigure.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class AppConfigure: NSObject {
    static let sharedInstance = AppConfigure()
    
    var isLoginUser = false
    var skinNumber = 0
    
    func checkAppConfigure() {
        isLoginUser = true
    }
}
