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
    
    func tableSeparatorColor() -> UIColor
    
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
    func cameraInfoListIcon() -> UIImage
    func skinSelectIcon() -> UIImage
    func versionInfoIcon() -> UIImage
    
    func fourCameraChannelIcon() -> UIImage
    func eightCameraChannelIcon() -> UIImage
    func listCameraChannelIcon() -> UIImage
    func galleryIcon() -> UIImage
    func galleryVideoBasicIcon() -> UIImage
    func galleryBackgroundColor() -> UIColor
    func galleryFontColor() -> UIColor
    func cameraChannelSmallViewImage() -> UIImage
    func pageControllerViewBackgroundColor() -> UIColor
    
    func cameraMenuFontColor() -> UIColor
}

class firstSkin: AppSkin {
    
    func userMenuViewBackgrounColor() -> UIColor {
        return UIColor(hex: "241F19")
    }
    
    func tableSeparatorColor() -> UIColor {
        return UIColor(hex: "443C30")
    }
    
    
    func navigationBarImage() -> UIImage {
        return UIImage(named: "title")!
    }
    
    func navigationIconColor() -> UIColor {
        return UIColor(hex: "746657")
    }

    func navigationBarColor() -> UIColor {
        return UIColor(hex: "241F19")
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
        return UIColor(hex: "241F19")
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
    
    func cameraInfoListIcon() -> UIImage {
        return UIImage(named: "ic_cctv")!
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
        return UIImage(named: "icn_3")!
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "icn_4")!
    }
    
    func galleryVideoBasicIcon() -> UIImage {
        return UIImage(named: "ic_file_video")!
    }
    
    func galleryBackgroundColor() -> UIColor {
        return UIColor(hex: "241F19")
    }
    
    func galleryFontColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func cameraChannelSmallViewImage() -> UIImage {
        return UIImage(named: "camera_channel")!
    }
    
    func pageControllerViewBackgroundColor() -> UIColor {
        return UIColor(hex: "9CD4DB")
    }
    
    
}
