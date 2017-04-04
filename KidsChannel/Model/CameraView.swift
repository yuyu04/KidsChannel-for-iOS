//
//  CameraView.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class CameraView: NSObject {
    var cameraUrlPath: URL!
    var movieView: UIView!
    var mediaPlayer: VLCMediaPlayer? = VLCMediaPlayer(options: ["--avi-index=2"])
    
    init(cameraUrl: URL, view: UIView) {
        super.init()
        self.cameraUrlPath = cameraUrl
        self.movieView = view
        //self.movieView.frame = view.bounds
        //view.addSubview(self.movieView)
        
        let media = VLCMedia(url: self.cameraUrlPath)
        mediaPlayer?.media = media
        
        mediaPlayer?.delegate = self
        mediaPlayer?.drawable = self.movieView
    }
    
    func startPlay() {
        self.mediaPlayer?.play()
    }
}

extension CameraView: VLCMediaPlayerDelegate {
    
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        print("mediaPlayerStateChanged(_ aNotification: Notification!)")
    }
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        print("mediaPlayerTimeChanged(_ aNotification: Notification!)")
    }
    
}
