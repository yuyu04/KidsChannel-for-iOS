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
        return 68
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? SkinSelectionTableViewCellData {
            self.cellImageView.image = data.image
        }
    }
    
}
