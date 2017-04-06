//
//  AlbumModel.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 6..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation
import Photos

class AlbumVideoModel {
    let asset:AVAsset
    init(asset:AVAsset, dic: [AnyHashable: Any]?) {
        self.asset = asset
        guard let info: [String: Any] = dic as! [String: Any]? else {
            return
        }
        
        print(info)
    }
    
    static func listVideoPHAsset() -> [PHAsset] {
        var videoList = [PHAsset]()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let userVideo = PHAsset.fetchAssets(with: .video, options: options)
        
        userVideo.enumerateObjects({ (object, count, stop) in
            videoList.append(object)
        })
        
        return videoList
    }
    
    /*static func listAlbumVideos() {
        var videoModelList = [AlbumVideoModel]()
        
        userVideo.enumerateObjects({ (object, count, stop) in
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestAVAsset(forVideo: object, options: .none) { (avAsset, avAudioMix, dict) in
                guard let asset = avAsset else {
                    return
                }
                let video = AlbumVideoModel(asset: asset, dic: dict)
                videoModelList.append(video)
            }
        })
        
        return videoModelList
    }*/
}
