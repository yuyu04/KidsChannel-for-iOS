//
//  StringExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    func encryptMD5() -> String {
        guard let plainData: Data = self.data(using: .utf8) else {
            return ""
        }
        
        let encryptedData = plainData.md5()
        let result: String = encryptedData.base64EncodedString()
        
        return result
    }
}
