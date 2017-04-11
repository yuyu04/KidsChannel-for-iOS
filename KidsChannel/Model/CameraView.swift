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
    var cameraUrlPath: URL!
    var movieView: UIView!
    var mediaPlayer: VLCMediaPlayer? = VLCMediaPlayer(options: ["--avi-index=2"])
    var container: UIView?
    var isFullScreenMode = false
    var isLoadingComplete = false
    var delegate: CameraViewDelegate?
    var tag: Int = 0
    var loadingCount: Int = 0
    
    init(cameraUrl: URL, camera: Camera, view: UIView) {
        super.init()
        
        isLoadingComplete = false
        self.cameraUrlPath = cameraUrl
        self.camera = camera
        self.movieView = view
        
        //Add tap gesture to movieView for play/pause
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CameraView.movieViewTapped(_:)))
        self.movieView.addGestureRecognizer(gesture)
        
        //self.movieView.frame = view.bounds
        //view.addSubview(self.movieView)
        
        let media = VLCMedia(url: self.cameraUrlPath)
        mediaPlayer?.media = media
        
        mediaPlayer?.delegate = self
        mediaPlayer?.drawable = self.movieView
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
