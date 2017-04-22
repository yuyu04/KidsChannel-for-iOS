//
//  SkinSelectionTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct SkinSelectionTableViewCellData {
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    var image: UIImage
    var text: String
}

class SkinSelectionTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
    }
    
    override class func height() -> CGFloat {
        if(UI_USER_INTERFACE_IDIOM() == .pad) {
            return 90
        } else {
            return 64
        }
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? SkinSelectionTableViewCellData {
            self.cellImageView.image = data.image
        }
    }
    
}
