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
    var streamUrl: URL?
    
    init(camera: Camera, streamUrl: URL?) {
        self.camera = camera
        self.streamUrl = streamUrl
    }
}
