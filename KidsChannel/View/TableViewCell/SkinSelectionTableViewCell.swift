//
//  SkinSelectionTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct SkinSelectionTableViewCellData {
    
    init(imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
    }
    var imageName: String
    var text: String
}

class SkinSelectionTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
    }
    
    override class func height() -> CGFloat {
        return 44
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? SkinSelectionTableViewCellData {
            if data.imageName.length > 0 {
                self.cellImageView.image = UIImage(named: data.imageName)
            }
        }
    }
    
}
