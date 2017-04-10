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
    let creationDate: String
    let duration: String
    let asset: PHAsset
    init(creationDate: Date, asset: PHAsset) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateString = dateformatter.string(from: creationDate)
        
        self.creationDate = dateString
        self.asset = asset
        self.duration = asset.duration.string()
    }
    
    static func listAlbumVideoModel() -> [AlbumVideoModel] {
        var videoList = [AlbumVideoModel]()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let userVideo = PHAsset.fetchAssets(with: .video, options: options)
        
        userVideo.enumerateObjects({ (object, count, stop) in
            guard let creationDate = object.creationDate,
                let fileName = object.originalFileName else {
                return
            }
            
            let range = fileName.range(of: "KidsChannel")
            if range != nil {
                let model = AlbumVideoModel(creationDate: creationDate, asset: object)
                videoList.append(model)
            }
        })
        
        return videoList
    }
    
    static func getAVAsset(from phasset:PHAsset, completion: @escaping (_ asset: AVAsset, _ audioMix: AVAudioMix?, _ dic: [AnyHashable: Any]?) -> Void) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager.default().requestAVAsset(forVideo: phasset, options: .none) { (avAsset, avAudioMix, dict) in
            guard let set = avAsset else {
                return
            }
            completion(set, avAudioMix, dict)
        }
    }
    
    static func getThumbnail(from avAsset:AVAsset) -> UIImage? {
        let imgGenerator = AVAssetImageGenerator(asset: avAsset)
        do {
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage
        } catch {
            print("failed getThumbnail. \(error.localizedDescription)")
        }
        
        return nil
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
