//
//  Camera.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

struct Camera {
    let idx : String
    let name : String
    let ip : String
    let port : String
    let id : String
    let password : String
    let number : String
    let updateTime : String
    let cameraCaptureUrl : String
}

extension Camera: Equatable {}

func ==(lhs: Camera, rhs: Camera) -> Bool {
    return (lhs.idx == rhs.idx) && (lhs.name == rhs.name)
}
