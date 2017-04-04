//
//  AppConfigure.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

enum SkinNumber : Int {
    case first = 0
    case second
    case third
    case fourth
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SkinNumber(rawValue: max) { max += 1 }
        return max
    }()
    
    func getSkinImageString() -> String {
        return ""
    }
}

class AppConfigure: NSObject {
    static let sharedInstance = AppConfigure()
    
    let userDefaults = UserDefaults.standard
    var isLoginUser = false
    var appSkin: AppSkin!
    var kindergartenName = ""
    weak var leftMenuDelegate: LeftMenuProtocol?
    
    override init() {
        super.init()
        
        if let skinNumber: SkinNumber = SkinNumber(rawValue: self.userDefaults.integer(forKey: "AppSkin")) {
            self.changeSkin(skinNumber: skinNumber)
        } else {
            self.changeSkin(skinNumber: .first)
        }
    }
    
    func checkAppConfigure() {
        isLoginUser = true
    }
    
    func changeSkin(skinNumber: SkinNumber) {
        switch skinNumber {
        case .first:
            appSkin = firstSkin()
        case .second:
            appSkin = firstSkin()
        case .third:
            appSkin = firstSkin()
        case .fourth:
            appSkin = firstSkin()
        }
    }
}
