//
//  UIButton.swift
//  KidsChannel
//
//  Created by InkaMacAir on 2017. 4. 16..
//  Copyright © 2017년 sungju. All rights reserved.
//

import Foundation

extension UIButton {
    func setRoundAndShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func separateJoinBtn(string: String) {
        //getting the range to separate the button title strings
        
        let fullNameArr = string.characters.split{$0 == "\n"}.map(String.init)
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(fullNameArr.count > 1) {
            substring1 = fullNameArr[0]
            substring1 += "\n\n"
            substring2 = fullNameArr[1]
        }
        
        //assigning diffrent fonts to both substrings
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let dict1:[String:Any] = [
            NSUnderlineStyleAttributeName:NSUnderlineStyle.styleNone.rawValue,
            NSFontAttributeName:UIFont.systemFont(ofSize: 13.0),
            NSForegroundColorAttributeName:UIColor.gray,
            NSParagraphStyleAttributeName:paragraph
        ]
        
        let dict2:[String:Any] = [
            NSUnderlineStyleAttributeName:NSUnderlineStyle.styleNone.rawValue,
            NSFontAttributeName:UIFont.systemFont(ofSize: 17.0),
            NSParagraphStyleAttributeName:paragraph
        ]
        
        let attString = NSMutableAttributedString()
        attString.append(NSAttributedString(string: substring1, attributes: dict1))
        attString.append(NSAttributedString(string: substring2, attributes: dict2))
        
        /*let att = NSMutableAttributedString(string: "\(substring1)\n\n\(substring2)");
        att.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 13.0), range: NSRange(location: 0, length: substring1.characters.count))
        att.addAttribute(NSForegroundColorAttributeName, value: UIColor.gray, range: NSRange(location: 0, length: substring1.characters.count))
        //att.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: 0, length: substring1.characters.count))
        
        att.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 17.0), range: NSRange(location: substring1.characters.count+2, length: substring2.characters.count))
        att.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range:  NSRange(location: substring1.characters.count+2, length: substring2.characters.count))
        att.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSRange(location: substring1.characters.count+2, length: substring2.characters.count))*/
        
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.lineBreakMode = .byWordWrapping
        self.setAttributedTitle(attString, for: .normal)
    }
}
