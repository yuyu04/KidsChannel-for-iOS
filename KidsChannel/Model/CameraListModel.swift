//
//  CameraListChannelViewModel.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 13..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation
import UIKit

class CameraListModel {
    let camera: Camera
    var streamUrl: URL
    
    init(camera: Camera, streamUrl: URL) {
        self.camera = camera
        self.streamUrl = streamUrl
        /*if let url = URL(string: camera.cameraCaptureUrl),
            let imageData = try? Data(contentsOf: url) {
            self.thumbnail = UIImage(data: imageData)
        }*/
    }
    
    /*func settingStreamUrl(_ completion: (Void) -> Void?) {
        
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let password = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserPassword") else {
                print("userId and password not found")
                return
        }
        
        let queue = DispatchQueue(label: "com.kidschannel.queue", qos: .userInteractive, attributes: .concurrent)
        queue.async {
            let cameraPath = "http://" + self.camera.ip + ":" + self.camera.port
            let onvif = iOSOnvif(cameraPath: cameraPath, userId: userId, password: password)
            self.streamUrl = onvif?.getStreamUrl()
        }
        
        if let url = URL(string: camera.cameraCaptureUrl),
            let imageData = try? Data(contentsOf: url) {
            self.thumbnail = UIImage(data: imageData)
        }
        
        completion()
    }*/

    /*static func searchCameraStream(_ completion: @escaping (_ cameraListModel: [CameraListModel]) -> Void) {
        var cameraListModel = [CameraListModel]()
        CameraManager.searchForCameraList() { (cameraList) in
            for camera in cameraList {
                let cameraObject = CameraListModel(camera: camera)
                cameraListModel.append(cameraObject)
            }
            completion(cameraListModel)
        }
    }*/
}
