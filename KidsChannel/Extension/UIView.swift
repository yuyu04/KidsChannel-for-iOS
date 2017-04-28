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
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                self.setBackgroundImage(data: data)
            }
        }
    }
    
    func setBackgroundImage(data: Data) {
        UIGraphicsBeginImageContext(self.frame.size)
        UIImage(data: data)?.draw(in: self.bounds)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        self.backgroundColor = UIColor(patternImage: image)
    }
}
