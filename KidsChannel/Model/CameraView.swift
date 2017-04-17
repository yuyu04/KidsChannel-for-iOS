//
//  CameraView.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

protocol CameraViewDelegate {
    func cameraView(didTapFullScreenMode cameraView: CameraView)
    func cameraView(didFinishLoading cameraView: CameraView)
}

class CameraView: NSObject {
    var camera: Camera!
    var cameraUrlPath: URL?
    var movieView: UIView!
    var mediaPlayer: VLCMediaPlayer? = VLCMediaPlayer(options: ["--avi-index=2"])
    var container: UIView?
    var isFullScreenMode = false
    var isLoadingComplete = false
    var delegate: CameraViewDelegate?
    var tag: Int = 0
    var loadingCount: Int = 0
    
    var configCameraList = AppConfigure.sharedInstance.cameraList
    
    let queue = DispatchQueue(label: "com.kidschannel.queue", qos: .userInteractive, attributes: .concurrent)
    
    init(camera: Camera, view: UIView) {
        super.init()
        
        isLoadingComplete = false
        self.camera = camera
        self.movieView = view
        
        //Add tap gesture to movieView for play/pause
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CameraView.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
        
        if cameraUrlPath == nil {
            self.setStreamUrl()
        }
        
        //self.movieView.frame = view.bounds
        //view.addSubview(self.movieView)
    }
    
    func setStreamUrl() {
        let index = configCameraList.index(where: {
            $0.camera == camera
        })
        
        if index == nil || configCameraList[index!].streamUrl == nil {
            self.getStreamUrl() { (url) in
                let model = CameraListModel(camera: self.camera, streamUrl: url)
                self.configCameraList.append(model)
                self.setVLCPlayer(url: url)
            }
        } else {
            self.setVLCPlayer(url: configCameraList[index!].streamUrl!)
        }
    }
    
    func getStreamUrl(completion: @escaping (_ url: URL) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let password = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserPassword") else {
                print("userId and password not found")
                return
        }
        
        queue.async {
            let cameraPath = "http://" + self.camera.ip + ":" + self.camera.port
            let onvif = iOSOnvif(cameraPath: cameraPath, userId: userId, password: password)
            
            self.cameraUrlPath = onvif?.getStreamUrl()
            if self.cameraUrlPath == nil {
                return
            }
            DispatchQueue.main.async {
                completion(self.cameraUrlPath!)
            }
        }
    }
    
    func setVLCPlayer(url: URL) {
        let media = VLCMedia(url: url)
        let aspactRatio = "1:" + String(describing: self.movieView.bounds.height / self.movieView.bounds.width)
        let ratio = aspactRatio.cString(using: .utf8)
        mediaPlayer?.videoAspectRatio = UnsafeMutablePointer<Int8>(mutating: ratio)
        mediaPlayer?.media = media
        
        mediaPlayer?.delegate = self
        mediaPlayer?.drawable = self.movieView
        self.startPlay()
        print("mediaPlayer?.videoAspectRatio = \(String(describing: mediaPlayer?.videoAspectRatio))")
    }
    
    func startPlay() {
        self.mediaPlayer?.play()
        isLoadingComplete = false
        loadingCount = 0
    }
    
    func stopPlay() {
        self.mediaPlayer?.stop()
        isLoadingComplete = false
        loadingCount = 0
    }
    
    func isPlayerPlaying() -> Bool {
        guard let isPlaying = self.mediaPlayer?.isPlaying else {
            return false
        }
        return isPlaying
    }
    
    func showActivityIndicatory() {
        if self.container != nil {
            return
        }
        
        self.container = UIView()
        container?.frame = self.movieView.frame
        container?.center = self.movieView.center
        container?.backgroundColor = UIColor(hex: "ffffff", alpha: 0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.movieView.center
        loadingView.backgroundColor = UIColor(hex: "444444", alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle = .whiteLarge
            actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                    y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container?.addSubview(loadingView)
        self.movieView.addSubview(container!)
        actInd.startAnimating()
    }
    
    func closeActivityIndicatory() {
        if self.container == nil {
            return
        }
        
        self.container?.removeFromSuperview()
        self.container = nil
    }
    
    func movieViewTapped(_ sender: UITapGestureRecognizer) {
        if isLoadingComplete {
            self.delegate?.cameraView(didTapFullScreenMode: self)
        }        
    }
}

extension CameraView: VLCMediaPlayerDelegate {
    
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
    }
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        if loadingCount >= 4 {
            self.delegate?.cameraView(didFinishLoading: self)
        } else {
            loadingCount += 1
        }
        
        isLoadingComplete = true
    }
    
}
