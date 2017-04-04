//
//  CameraManager.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class CameraManager: NSObject {
    
    static func searchForCameraList(completion: @escaping (_ cameraList: [Camera]) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            AppConfigure.sharedInstance.isLoginUser else {
                return
        }
        
        NetworkManager.requestCameraSearch(userId: userId) { (cameraArray) in
            guard let cameraList = cameraArray else {
                return
            }
            
            DispatchQueue.main.async {
                completion(cameraList)
            }
        }
    }
    
    static func getStreamForPlay(cameraList: [Camera], completion: @escaping (_ streamList: [URL]) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let password = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserPassword") else {
                print("userId and password not found")
                return
            }
        
        let queue = DispatchQueue(label: "com.kidschannel.queue", qos: .userInteractive, attributes: .concurrent)
        let group = DispatchGroup()
        
        var streamUrls = [URL]()
        queue.async {
            DispatchQueue.concurrentPerform(iterations: cameraList.count) { index in
                group.enter()
                let camera = cameraList[index]
                
                let cameraPath = "http://" + camera.ip + ":" + camera.port
                let onvif = iOSOnvif(cameraPath: cameraPath, userId: userId, password: password)
                let streamUrl = onvif?.getStreamUrl()
                group.leave()
                if streamUrl != nil {
                    streamUrls.append(streamUrl!)
                }
            }
            
            group.notify(queue: DispatchQueue.main) { Void in
                completion(streamUrls)
            }
        }
    }
}
