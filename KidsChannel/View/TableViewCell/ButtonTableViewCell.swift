//
//  CameraButtonTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct ButtonTableViewCellData {
    
    init(image: UIImage?, text: String) {
        self.image = image
        self.text = text
    }
    var image: UIImage?
    var text: String
}

class ButtonTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
        cellTextLabel.textColor = AppConfigure.sharedInstance.appSkin.userMenuFontColor()
        cellImageView.tintColor = AppConfigure.sharedInstance.appSkin.iconsNormalTintColor()
    }
    
    override class func height() -> CGFloat {
        return 44
    }

    override func setData(_ data: Any?) {
        if let data = data as? ButtonTableViewCellData {
            if data.image != nil {
                self.cellImageView.image = data.image
            }            
            self.cellTextLabel.text = data.text
        }
    }
    
}
