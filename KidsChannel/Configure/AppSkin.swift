//
//  SkinKinds.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

protocol AppSkin {
    func mainViewImage() -> UIImage
    func iconColor() -> UIColor
    func loginImage() -> UIImage
    func notLoginImage() -> UIImage
    func navigationBarColor() -> UIColor
    func userMenuFontColor() -> UIColor
    func cameraMenuFontColor() -> UIColor
}

class firstSkin: AppSkin {
    func cameraMenuFontColor() -> UIColor {
        return UIColor(hex: "777777")
    }

    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "777777")
    }

    func navigationBarColor() -> UIColor {
        return UIColor(hex: "777777")
    }

    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }

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
