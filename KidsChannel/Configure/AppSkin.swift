//
//  SkinKinds.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

protocol AppSkin {
    func mainBackgroundPatternImage() -> UIImage
    func mainBackgroundImage() -> UIImage
    
    func userMenuViewBackgrounColor() -> UIColor
    
    func tableSeparatorColor() -> UIColor
    
    func loginImage() -> UIImage
    func notLoginImage() -> UIImage
    
    func navigationBarImage() -> UIImage
    func navigationIconColor() -> UIColor
    func navigationBarColor() -> UIColor
    func navigationLeftButtonImage() -> UIImage
    func navigationRightButtonImage() -> UIImage
    
    func userIdFontColor() -> UIColor
    func userMenuFontColor() -> UIColor
    func userMenuViewsBackgroundImage() -> UIImage
    func userMenuViewsPatternImage() -> UIImage
    func iconsNormalTintColor() -> UIColor
    func iconsSelectTintColor() -> UIColor
    func userInfoIcon() -> UIImage
    func cameraInfoIcon() -> UIImage
    func cameraInfoListIcon() -> UIImage
    func skinSelectIcon() -> UIImage
    func versionInfoIcon() -> UIImage
    func userMenuButtonColor1() -> UIColor
    func userMenuButtonColor2() -> UIColor
    func userMenuButtonColor3() -> UIColor
    
    func fourCameraChannelIcon() -> UIImage
    func otherChannelBackgroundColor() -> UIColor
    func galleryIcon() -> UIImage
    func galleryVideoBasicIcon() -> UIImage
    func galleryBackgroundColor() -> UIColor
    func galleryFontColor() -> UIColor
    func cameraChannelSmallViewImage() -> UIImage
    func pageControllerViewBackgroundColor() -> UIColor
}

class firstSkin: AppSkin {
    
    func mainBackgroundPatternImage() -> UIImage {
        return UIImage(named: "skin01_bg_main")!
    }
    
    func mainBackgroundImage() -> UIImage {
        return UIImage(named: "skin01_layout_main")!
    }
    
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
        return UIColor(hex: "42392d")
    }

    func navigationBarColor() -> UIColor {
        return UIColor(hex: "241F19")
    }
    
    func navigationLeftButtonImage() -> UIImage {
        return UIImage(named: "ic_skin01_menu")!
    }
    
    func navigationRightButtonImage() -> UIImage {
        return UIImage(named: "ic_skin01_view")!
    }

    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "skin01_profile_in")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "skin01_profile_out")!
    }
    
    func iconsNormalTintColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func iconsSelectTintColor() -> UIColor {
        return UIColor(hex: "241F19")
    }
    
    func userMenuViewsBackgroundImage() -> UIImage {
        return UIImage(named: "skin01_layout_sub")!
    }
    
    func userMenuViewsPatternImage() -> UIImage {
        return UIImage(named: "skin01_bg_sub")!
    }
    
    func userIdFontColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "999999")
    }
    
    func cameraInfoListIcon() -> UIImage {
        return UIImage(named: "ic_cctv")!
    }
    
    func userInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin01_menu_01")!
    }
    
    func cameraInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin01_menu_02")!
    }
    
    func skinSelectIcon() -> UIImage {
        return UIImage(named: "ic_skin01_menu_03")!
    }
    
    func versionInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin01_menu_04")!
    }
    
    func userMenuButtonColor1() -> UIColor {
        return UIColor(hex: "00C2C3")
    }
    
    func userMenuButtonColor2() -> UIColor {
        return UIColor(hex: "0993C5")
    }
    
    func userMenuButtonColor3() -> UIColor {
        return UIColor(hex: "535352")
    }
    
    func fourCameraChannelIcon() -> UIImage {
        return UIImage(named: "ic_skin01_view_01")!
    }
    
    func otherChannelBackgroundColor() -> UIColor {
        return UIColor(hex: "535352")
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "ic_skin01_view_02")!
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

class secondSkin: AppSkin {
    
    func mainBackgroundPatternImage() -> UIImage {
        return UIImage(named: "skin02_bg_main")!
    }
    
    func mainBackgroundImage() -> UIImage {
        return UIImage(named: "skin02_layout_main")!
    }
    
    func userMenuViewBackgrounColor() -> UIColor {
        return UIColor(hex: "F1F1F1")
    }
    
    func tableSeparatorColor() -> UIColor {
        return UIColor(hex: "E6E7E6")
    }
    
    func navigationBarImage() -> UIImage {
        return UIImage(named: "title_dark")!
    }
    
    func navigationIconColor() -> UIColor {
        return UIColor(hex: "909BCC")
    }
    
    func navigationBarColor() -> UIColor {
        return UIColor(hex: "F1F1F1")
    }
    
    func navigationLeftButtonImage() -> UIImage {
        return UIImage(named: "ic_skin02_menu")!
    }
    
    func navigationRightButtonImage() -> UIImage {
        return UIImage(named: "ic_skin02_view")!
    }
    
    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "skin02_profile_in")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "skin02_profile_out")!
    }
    
    func iconsNormalTintColor() -> UIColor {
        return UIColor(hex: "99ABE6")
    }
    
    func iconsSelectTintColor() -> UIColor {
        return UIColor(hex: "241F19")
    }
    
    func userMenuViewsBackgroundImage() -> UIImage {
        return UIImage(named: "skin02_layout_sub")!
    }
    
    func userMenuViewsPatternImage() -> UIImage {
        return UIImage(named: "skin02_bg_sub")!
    }
    
    func userIdFontColor() -> UIColor {
        return UIColor(hex: "C1C6DC")
    }
    
    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "A5A6A5")
    }
    
    func cameraInfoListIcon() -> UIImage {
        return UIImage(named: "ic_cctv")!
    }
    
    func userInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin02_menu_01")!
    }
    
    func cameraInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin02_menu_02")!
    }
    
    func skinSelectIcon() -> UIImage {
        return UIImage(named: "ic_skin02_menu_03")!
    }
    
    func versionInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin02_menu_04")!
    }
    
    func userMenuButtonColor1() -> UIColor {
        return UIColor(hex: "00C2C3")
    }
    
    func userMenuButtonColor2() -> UIColor {
        return UIColor(hex: "0993C5")
    }
    
    func userMenuButtonColor3() -> UIColor {
        return UIColor(hex: "535352")
    }
    
    func fourCameraChannelIcon() -> UIImage {
        return UIImage(named: "ic_skin02_view_01")!
    }
    
    func otherChannelBackgroundColor() -> UIColor {
        return UIColor(hex: "BAC2DE")
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "ic_skin02_view_02")!
    }
    
    func galleryVideoBasicIcon() -> UIImage {
        return UIImage(named: "ic_file_video")!
    }
    
    func galleryBackgroundColor() -> UIColor {
        return UIColor(hex: "F6F6F1")
    }
    
    func galleryFontColor() -> UIColor {
        return UIColor(hex: "A5A6A5")
    }
    
    func cameraChannelSmallViewImage() -> UIImage {
        return UIImage(named: "camera_channel")!
    }
    
    func pageControllerViewBackgroundColor() -> UIColor {
        return UIColor(hex: "F6F6F1")
    }
}


class thirdSkin: AppSkin {
    
    func mainBackgroundPatternImage() -> UIImage {
        return UIImage(named: "skin03_bg_main")!
    }
    
    func mainBackgroundImage() -> UIImage {
        return UIImage(named: "skin03_layout_main")!
    }
    
    func userMenuViewBackgrounColor() -> UIColor {
        return UIColor(hex: "66C3C7")
    }
    
    func tableSeparatorColor() -> UIColor {
        return UIColor(hex: "55B9BE")
    }
    
    func navigationBarImage() -> UIImage {
        return UIImage(named: "title")!
    }
    
    func navigationIconColor() -> UIColor {
        return UIColor(hex: "C8E9E9")
    }
    
    func navigationBarColor() -> UIColor {
        return UIColor(hex: "66C3C7")
    }
    
    func navigationLeftButtonImage() -> UIImage {
        return UIImage(named: "ic_skin03_menu")!
    }
    
    func navigationRightButtonImage() -> UIImage {
        return UIImage(named: "ic_skin03_view")!
    }
    
    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "skin03_profile_in")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "skin03_profile_out")!
    }
    
    func iconsNormalTintColor() -> UIColor {
        return UIColor(hex: "E1F3F0")
    }
    
    func iconsSelectTintColor() -> UIColor {
        return UIColor(hex: "60BFC4")
    }
    
    func userMenuViewsBackgroundImage() -> UIImage {
        return UIImage(named: "skin03_layout_sub")!
    }
    
    func userMenuViewsPatternImage() -> UIImage {
        return UIImage(named: "skin01_bg_sub")!
    }
    
    func userIdFontColor() -> UIColor {
        return UIColor(hex: "E4F2EF")
    }
    
    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "D1E8E7")
    }
    
    func cameraInfoListIcon() -> UIImage {
        return UIImage(named: "ic_cctv")!
    }
    
    func userInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin03_menu_01")!
    }
    
    func cameraInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin03_menu_02")!
    }
    
    func skinSelectIcon() -> UIImage {
        return UIImage(named: "ic_skin03_menu_03")!
    }
    
    func versionInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin03_menu_04")!
    }
    
    func userMenuButtonColor1() -> UIColor {
        return UIColor(hex: "00C2C3")
    }
    
    func userMenuButtonColor2() -> UIColor {
        return UIColor(hex: "0993C5")
    }
    
    func userMenuButtonColor3() -> UIColor {
        return UIColor(hex: "535352")
    }
    
    func fourCameraChannelIcon() -> UIImage {
        return UIImage(named: "ic_skin03_view_01")!
    }
    
    func otherChannelBackgroundColor() -> UIColor {
        return UIColor(hex: "B3E1E1")
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "ic_skin03_view_02")!
    }
    
    func galleryVideoBasicIcon() -> UIImage {
        return UIImage(named: "ic_file_video")!
    }
    
    func galleryBackgroundColor() -> UIColor {
        return UIColor(hex: "F3F4EC")
    }
    
    func galleryFontColor() -> UIColor {
        return UIColor(hex: "E5F2EF")
    }
    
    func cameraChannelSmallViewImage() -> UIImage {
        return UIImage(named: "camera_channel")!
    }
    
    func pageControllerViewBackgroundColor() -> UIColor {
        return UIColor(hex: "F3F4EC")
    }
}


class forthSkin: AppSkin {
    
    func mainBackgroundPatternImage() -> UIImage {
        return UIImage(named: "skin04_bg_main")!
    }
    
    func mainBackgroundImage() -> UIImage {
        return UIImage(named: "skin04_layout_main")!
    }
    
    func userMenuViewBackgrounColor() -> UIColor {
        return UIColor(hex: "444443")
    }
    
    func tableSeparatorColor() -> UIColor {
        return UIColor(hex: "333332")
    }
    
    func navigationBarImage() -> UIImage {
        return UIImage(named: "title")!
    }
    
    func navigationIconColor() -> UIColor {
        return UIColor(hex: "A2A29F")
    }
    
    func navigationBarColor() -> UIColor {
        return UIColor(hex: "444443")
    }
    
    func navigationLeftButtonImage() -> UIImage {
        return UIImage(named: "ic_skin04_menu")!
    }
    
    func navigationRightButtonImage() -> UIImage {
        return UIImage(named: "ic_skin04_view")!
    }
    
    func mainViewImage() -> UIImage {
        return UIImage(named: "")!
    }
    
    func loginImage() -> UIImage {
        return UIImage(named: "skin04_profile_in")!
    }
    
    func notLoginImage() -> UIImage {
        return UIImage(named: "skin04_profile_out")!
    }
    
    func iconsNormalTintColor() -> UIColor {
        return UIColor(hex: "BEBEBA")
    }
    
    func iconsSelectTintColor() -> UIColor {
        return UIColor(hex: "4E4E4C")
    }
    
    func userMenuViewsBackgroundImage() -> UIImage {
        return UIImage(named: "skin04_layout_sub")!
    }
    
    func userMenuViewsPatternImage() -> UIImage {
        return UIImage(named: "skin04_bg_sub")!
    }
    
    func userIdFontColor() -> UIColor {
        return UIColor(hex: "969693")
    }
    
    func userMenuFontColor() -> UIColor {
        return UIColor(hex: "B5B5B1")
    }
    
    func cameraInfoListIcon() -> UIImage {
        return UIImage(named: "ic_cctv")!
    }
    
    func userInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin04_menu_01")!
    }
    
    func cameraInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin04_menu_02")!
    }
    
    func skinSelectIcon() -> UIImage {
        return UIImage(named: "ic_skin04_menu_03")!
    }
    
    func versionInfoIcon() -> UIImage {
        return UIImage(named: "ic_skin04_menu_04")!
    }
    
    func userMenuButtonColor1() -> UIColor {
        return UIColor(hex: "00C2C3")
    }
    
    func userMenuButtonColor2() -> UIColor {
        return UIColor(hex: "0993C5")
    }
    
    func userMenuButtonColor3() -> UIColor {
        return UIColor(hex: "535352")
    }
    
    func fourCameraChannelIcon() -> UIImage {
        return UIImage(named: "ic_skin04_view_01")!
    }
    
    func otherChannelBackgroundColor() -> UIColor {
        return UIColor(hex: "282827")
    }
    
    func galleryIcon() -> UIImage {
        return UIImage(named: "ic_skin04_view_02")!
    }
    
    func galleryVideoBasicIcon() -> UIImage {
        return UIImage(named: "ic_file_video")!
    }
    
    func galleryBackgroundColor() -> UIColor {
        return UIColor(hex: "FFFFFB")
    }
    
    func galleryFontColor() -> UIColor {
        return UIColor(hex: "BABAB6")
    }
    
    func cameraChannelSmallViewImage() -> UIImage {
        return UIImage(named: "camera_channel")!
    }
    
    func pageControllerViewBackgroundColor() -> UIColor {
        return UIColor(hex: "FFFFFB")
    }
}

