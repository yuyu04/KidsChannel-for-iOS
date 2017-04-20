//
//  orientationManager.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 19..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

class OrientationManager {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
}
