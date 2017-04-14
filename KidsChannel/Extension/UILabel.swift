//
//  UILabel.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 13..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

extension UILabel {
    func setStrokedText(text: String) {
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeWidthAttributeName : -4.0,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)
            ] as [String : Any]
        self.attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
    }
}
