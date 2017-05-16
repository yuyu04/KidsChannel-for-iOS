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
    
    static func getStreamForPlay(cameraList: [Camera], completion: @escaping (_ streamList: [(camera: Camera, url: URL?)]) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let password = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserPassword") else {
                print("userId and password not found")
                return
            }
        
        let queue = DispatchQueue(label: "com.kidschannel.queue", qos: .userInteractive, attributes: .concurrent)
        queue.async {
            var streams = [(camera: Camera, url: URL?)]()
            for camera in cameraList {
                let index = AppConfigure.sharedInstance.cameraList.index(where: {
                    $0.camera == camera
                })
                
                var streamUrl: URL?
                if index != nil {
                    streamUrl = AppConfigure.sharedInstance.cameraList[index!].streamUrl
                    streams.append((camera: camera, url: streamUrl))
                    continue
                }
                
                if camera.cameraRtspUrl.length > 0 {
                    streamUrl = URL(string: camera.cameraRtspUrl)
                } else {
                    let cameraPath = "http://" + camera.ip + ":" + camera.port
                    let onvif = iOSOnvif(cameraPath: cameraPath, userId: userId, password: password)
                    
                    streamUrl = onvif?.getStreamUrl()
                    if streamUrl == nil {
                        streamUrl = onvif?.getStreamUrl()
                    }
                }
                
                streams.append((camera: camera, url: streamUrl))
            }
            
            DispatchQueue.main.async {
                completion(streams)
            }
        }
    }
}
