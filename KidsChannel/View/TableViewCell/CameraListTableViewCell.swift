//
//  CameraListTableViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 31..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct CameraListTableViewCellData {
    
    init(image: UIImage, cameraName: String, cameraUrl: String, cameraId: String, cameraIdx: String) {
        self.image = image
        self.cameraName = cameraName
        self.cameraUrl = cameraUrl
        self.cameraId = cameraId
        self.cameraIdx = cameraIdx
    }
    var image: UIImage
    var cameraName: String
    var cameraUrl: String
    var cameraId: String
    var cameraIdx: String
}

class CameraListTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellCameraNameLabel: UILabel!
    @IBOutlet weak var cellCameraUrlLabel: UILabel!
    @IBOutlet weak var cellCameraIdLabel: UILabel!
    
    var cameraIdx: String!
    
    override func awakeFromNib() {
        // Initialization code
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
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
            self.cameraIdx = data.cameraIdx
        }
    }
}
