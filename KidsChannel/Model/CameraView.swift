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
    
    let queue = DispatchQueue(label: "com.kidschannel.queue", qos: .userInteractive, attributes: .concurrent)
    
    init(camera: Camera, view: UIView) {
        super.init()
        
        isLoadingComplete = false
        self.camera = camera
        
        self.setVideoView(view: view)
        
        if cameraUrlPath == nil {
            self.setStreamUrl()
        }
        
        //self.movieView.frame = view.bounds
        //view.addSubview(self.movieView)
    }
    
    func setVideoView(view: UIView) {
        self.movieView = view
        loadingCount = 0
        //Add tap gesture to movieView for play/pause
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CameraView.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
    }
    
    func setStreamUrl() {
        let index = AppConfigure.sharedInstance.cameraList.index(where: {
            $0.camera == camera
        })
        
        if index == nil || AppConfigure.sharedInstance.cameraList[index!].streamUrl == nil {
            if camera.cameraRtspUrl.length > 0, let rtspUrl = URL(string: camera.cameraRtspUrl) {
                let model = CameraListModel(camera: self.camera, streamUrl: rtspUrl)
                AppConfigure.sharedInstance.cameraList.append(model)
                self.setVLCPlayer(url: rtspUrl)
            } else {
                self.getStreamUrl() { (url) in
                    let model = CameraListModel(camera: self.camera, streamUrl: url)
                    AppConfigure.sharedInstance.cameraList.append(model)
                    self.setVLCPlayer(url: url)
                }
            }            
        } else {
            self.setVLCPlayer(url: AppConfigure.sharedInstance.cameraList[index!].streamUrl!)
        }
    }
    
    func getStreamUrl(completion: @escaping (_ url: URL) -> Void) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let password = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserPassword") else {
                print("userId and password not found")
                return
        }
        
        queue.async {
            while true {
                let cameraPath = "http://" + self.camera.ip + ":" + self.camera.port
                let onvif = iOSOnvif(cameraPath: cameraPath, userId: userId, password: password)
                
                self.cameraUrlPath = onvif?.getStreamUrl()
                if self.cameraUrlPath != nil {
                    break
                }
            }
            
            DispatchQueue.main.async {
                completion(self.cameraUrlPath!)
            }
        }
    }
    
    func setVLCPlayer(url: URL) {
        let media = VLCMedia(url: url)
        
        let gcdValue = gcd(Int(self.movieView.bounds.width), Int(self.movieView.bounds.height))
        let width = String(describing: Int(self.movieView.bounds.width)/gcdValue)
        let height = String(describing: Int(self.movieView.bounds.height)/gcdValue)
        let aspactRatio = "\(width):\(height)"
        let ratio = aspactRatio.cString(using: .utf8)
        let unsafePointer = UnsafeMutablePointer<Int8>(mutating: ratio)
        mediaPlayer?.videoAspectRatio = unsafePointer
        mediaPlayer?.media = media
        
        mediaPlayer?.delegate = self
        mediaPlayer?.drawable = self.movieView
        self.startPlay()
        print("mediaPlayer?.videoAspectRatio = \(String(describing: mediaPlayer?.videoAspectRatio))")
    }
    
    func startPlay() {
        loadingCount = 0
        self.mediaPlayer?.play()
        isLoadingComplete = false
    }
    
    func stopPlay() {
        loadingCount = 0
        self.mediaPlayer?.stop()
        isLoadingComplete = false
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
        if loadingCount == 2 {
            self.delegate?.cameraView(didFinishLoading: self)
        } else if loadingCount < 3 {
            loadingCount += 1
        }
        
        isLoadingComplete = true
    }
    
}

extension CameraView {
    // GCD of two numbers:
    func gcd(_ num1: Int, _ num2: Int) -> Int {
        if num2 == 0 {
            return num1
        }else {
            return gcd(num2, num1 % num2)
        }
    }
    
    func lcm(_ m: Int, _ n: Int) -> Int {
        return m*n / gcd(m, n)
    }
}
