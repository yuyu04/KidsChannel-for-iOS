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
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SkinNumber(rawValue: max) { max += 1 }
        return max
    }()
    
    static func getSkinImage(number: SkinNumber, selectedNumber: SkinNumber) -> UIImage {
        var image: UIImage!
        switch number {
        case .first:
            if selectedNumber == .first {
                image = UIImage(named: "skin_button_01_selected_pressed")!
            } else {
                image = UIImage(named: "skin_button_01_selected_normal")!
            }
        case .second:
            if selectedNumber == .second {
                image = UIImage(named: "skin_button_01_nonselected_pressed")!
            } else {
                image = UIImage(named: "skin_button_01_nonselected_normal")!
            }
        }
        return image    }
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
        }
    }
}
