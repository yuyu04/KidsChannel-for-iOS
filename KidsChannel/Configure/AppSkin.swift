//
//  SkinKinds.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

protocol AppSkin {
    func userMenuViewBackgrounColor() -> UIColor
    
    func loginImage() -> UIImage
    func notLoginImage() -> UIImage
    
    func navigationBarImage() -> UIImage
    func navigationIconColor() -> UIColor
    func navigationBarColor() -> UIColor
    func navigationLeftButtonImage() -> UIImage
    func navigationRightButtonImage() -> UIImage
    
    func userMenuFontColor() -> UIColor
    func userMenuViewsBackgroundImage() -> UIImage
    func iconsNormalTintColor() -> UIColor
    func iconsSelectTintColor() -> UIColor
    func userInfoIcon() -> UIImage
    func cameraInfoIcon() -> UIImage
    func skinSelectIcon() -> UIImage
    func versionInfoIcon() -> UIImage
    
    func fourCameraChannelIcon() -> UIImage
    func eightCameraChannelIcon() -> UIImage
    func listCameraChannelIcon() -> UIImage
    func galleryIcon() -> UIImage
    func pageControllerBottomBackgroundColor() -> UIColor
    
    func cameraMenuFontColor() -> UIColor
    func galleryVideoBasicIcon() -> UIImage
}

class firstSkin: AppSkin {
    
    func userMenuViewBackgrounColor() -> UIColor {
        return UIColor(hex: "262625")
    }

    
    
    func navigationBarImage() -> UIImage {
        return UIImage(named: "title")!
    }
    
    func navigationIconColor() -> UIColor {
        return UIColor(hex: "746657")
    }

    func navigationBarColor() -> UIColor {
        return UIColor(hex: "262625")
    }
    
    func navigationLeftButtonImage() -> UIImage {
        return UIImage(named: "ic_menu")!
    }
    
    func navigationRightButtonImage() -> UIImage {
        return UIImage(named: "ic_context")!
    }

    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "profile_picture")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "profile_local")!
    }
    
    func iconsNormalTintColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func iconsSelectTintColor() -> UIColor {
        return UIColor(hex: "262625")
    }
    
    func userMenuViewsBackgroundImage() -> UIImage {
        return UIImage(named: "skin_fragment_01")!
    }
    
    func cameraMenuFontColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func userInfoIcon() -> UIImage {
        return UIImage(named: "ic_menu_01")!
    }
    
    func cameraInfoIcon() -> UIImage {
        return UIImage(named: "ic_menu_02")!
    }
    
    func skinSelectIcon() -> UIImage {
        return UIImage(named: "ic_menu_03")!
    }
    
    func versionInfoIcon() -> UIImage {
        return UIImage(named: "ic_menu_04")!
    }
    
    func fourCameraChannelIcon() -> UIImage {
        return UIImage(named: "icn_1")!
    }
    
    func eightCameraChannelIcon() -> UIImage {
        return UIImage(named: "icn_2")!
    }
    
    func listCameraChannelIcon() -> UIImage {
        return UIImage(named: "icn_1")!
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "icn_1")!
    }
    
    func pageControllerBottomBackgroundColor() -> UIColor {
        return UIColor(hex: "262625")
    }
    
    func galleryVideoBasicIcon() -> UIImage {
        return UIImage(named: "ic_menu_black_24dp")!
    }
}
