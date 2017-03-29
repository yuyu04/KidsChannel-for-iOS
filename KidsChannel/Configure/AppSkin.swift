//
//  SkinKinds.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

protocol AppSkin {
    func iconColor() -> UIColor
    func loginImage() -> UIImage
    func notLoginImage() -> UIImage
}

class firstSkin: AppSkin {
    func iconColor() -> UIColor {
        return UIColor(hex: "777777")
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "")!
    }
}
