//
//  CameraListTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 31..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct CameraListTableViewCellData {
    
    init(image: UIImage, cameraName: String, cameraUrl: String, cameraId: String) {
        self.image = image
        self.cameraName = cameraName
        self.cameraUrl = cameraUrl
        self.cameraId = cameraId
    }
    var image: UIImage
    var cameraName: String
    var cameraUrl: String
    var cameraId: String
}

class CameraListTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCameraNameLabel: UILabel!
    @IBOutlet weak var cellCameraUrlLabel: UILabel!
    @IBOutlet weak var cellCameraIdLabel: UILabel!
    
    override func awakeFromNib() {
        // Initialization code
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override class func height() -> CGFloat {
        return 70
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? CameraListTableViewCellData {
            self.cellImageView.image = data.image
            self.cellCameraNameLabel.text = data.cameraName
            self.cellCameraUrlLabel.text = data.cameraUrl
            self.cellCameraIdLabel.text = data.cameraId
        }
    }
}
