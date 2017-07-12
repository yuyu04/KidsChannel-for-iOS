//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func setBackgrounImage(url: String) {
        NetworkManager.requestImageData(url: url) { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    self.setBackgroundImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.setBackgroundImage(named: "viewer_ipcamera")
                }
            }
        }
    }
    
    func setBackgroundImageForNotYetServiceTime() {
        DispatchQueue.main.async {
            self.setBackgroundImage(named: "viewer_not_service")
        }
    }
    
    func setBackgroundImage(data: Data) {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(data: data)?.draw(in: self.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.backgroundColor = UIColor(patternImage: image)
    }
    
    func setBackgroundImage(named: String) {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(named: named)!.draw(in: self.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.backgroundColor = UIColor(patternImage: image)
    }
}
