//
//  PHAsset.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 6..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Photos

extension PHAsset {
    
    var originalFileName: String? {
        
        var fname:String?
        
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }
        
        if fname == nil {
            // this is an undocumented workaround that works as of iOS 9.1
            fname = self.value(forKey: "filename") as? String
        }
        
        return fname
    }
}
