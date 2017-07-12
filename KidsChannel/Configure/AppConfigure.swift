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
    case forth
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SkinNumber(rawValue: max) { max += 1 }
        return max
    }()
    
    static func getSkinImage(number: SkinNumber, selectedNumber: SkinNumber) -> UIImage {
        var image: UIImage!
        let currentSkinNumber = AppConfigure.sharedInstance.skinNumber
        
        switch number {
        case .first where currentSkinNumber == number:
            if selectedNumber == .first {
                image = UIImage(named: "skin01_banner_selected_pressed")!
            } else {
                image = UIImage(named: "skin01_banner_selected_normal")!
            }
        case .first:
            if selectedNumber == .first {
                image = UIImage(named: "skin01_banner_nonselected_pressed")!
            } else {
                image = UIImage(named: "skin01_banner_nonselected_normal")!
            }
        case .second where currentSkinNumber == number:
            if selectedNumber == .second {
                image = UIImage(named: "skin02_banner_selected_pressed")!
            } else {
                image = UIImage(named: "skin02_banner_selected_normal")!
            }
        case .second:
            if selectedNumber == .second {
                image = UIImage(named: "skin02_banner_nonselected_pressed")!
            } else {
                image = UIImage(named: "skin02_banner_nonselected_normal")!
            }
        case .third where currentSkinNumber == number:
            if selectedNumber == .third {
                image = UIImage(named: "skin03_banner_selected_pressed")!
            } else {
                image = UIImage(named: "skin03_banner_selected_normal")!
            }
        case .third:
            if selectedNumber == .third {
                image = UIImage(named: "skin03_banner_nonselected_pressed")!
            } else {
                image = UIImage(named: "skin03_banner_nonselected_normal")!
            }
        case .forth where currentSkinNumber == number:
            if selectedNumber == .forth {
                image = UIImage(named: "skin04_banner_selected_pressed")!
            } else {
                image = UIImage(named: "skin04_banner_selected_normal")!
            }
        case .forth:
            if selectedNumber == .forth {
                image = UIImage(named: "skin04_banner_nonselected_pressed")!
            } else {
                image = UIImage(named: "skin04_banner_nonselected_normal")!
            }
        }
        
        return image
    }
}

let ServiceStatusNotification: NSNotification.Name = NSNotification.Name("ServiceStatusNotification")

class AppConfigure: NSObject {
    static let sharedInstance = AppConfigure()
    
    let userDefaults = UserDefaults.standard
    var isLoginUser = false
    var skinNumber: SkinNumber!
    var appSkin: AppSkin!
    var kindergartenName = ""
    var timer: Timer?
    weak var leftMenuDelegate: LeftMenuProtocol?
    
    var cameras = [Camera]()
    var cameraList = [CameraListModel]()
    
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
        self.skinNumber = skinNumber
        self.userDefaults.set(skinNumber.rawValue, forKey: "AppSkin")
        
        switch skinNumber {
        case .first:
            appSkin = firstSkin()
        case .second:
            appSkin = secondSkin()
        case .third:
            appSkin = thirdSkin()
        case .forth:
            appSkin = forthSkin()
        }
    }
    
    func startScheduling() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(loop), userInfo: nil, repeats: true)
        }
    }
    
    func stopScheduling() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func loop() {
        NetworkManager.requestServiceStatus() { (status) in
            let userInfo: [String:Any] = ["status": status]
            NotificationCenter.default.post(name: ServiceStatusNotification, object: nil, userInfo: userInfo)
        }
    }
    
    func searchCameraList(_ completion: ((Void) -> Void)?) {
        CameraManager.searchForCameraList() { (cameraList) in
            /*for camera in cameraList {
                let cameraModel = CameraListModel(camera: camera, streamUrl: <#URL#>)
                self.cameraList.append(cameraModel)
            }*/
            
            completion?()
            
            /*let slice = self.cameraAllList.slice(from: self.searchCount)
            CameraManager.getStreamForPlay(cameraList: slice) { (streamList) in
                self.searchCount.start = streamList.count-1
                for stream in streamList {
                    let camera = CameraListModel(camera: stream.camera, streamUrl: stream.url)
                    self.cameraList.append(camera)
                    
                    collectionView?.performBatchUpdates({ () -> Void in
                        self.collectionView?.insertItems(at: indexPath)
                    }, completion: { (finished) -> Void in
                        handler()
                    })
                }
            }*/
        }
    }
}
