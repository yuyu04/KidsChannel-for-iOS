//
//  CameraButtonTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct ButtonTableViewCellData {
    
    init(imageName: String, text: String) {
        self.imageName = imageName
        self.text = text
    }
    var imageName: String
    var text: String
}

class ButtonTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
    }
    
    override class func height() -> CGFloat {
        return 44
    }

    override func setData(_ data: Any?) {
        if let data = data as? ButtonTableViewCellData {
            if data.imageName.length > 0 {
                self.cellImageView.image = UIImage(named: data.imageName)
            }            
            self.cellTextLabel.text = data.text
        }
    }
    
}
