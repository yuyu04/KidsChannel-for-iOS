//
//  ImageHeaderView.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class ImageHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */

    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var userId : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImage.layoutIfNeeded()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = self.backgroundColor?.cgColor
    }
}
