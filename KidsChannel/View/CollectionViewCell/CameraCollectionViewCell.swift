//
//  CameraCollectionViewCell.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 13..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

struct CameraCollectionViewCellData {
    
    init(image: UIImage?, cameraName: String, time: String, cameraIdx: String) {
        self.image = image
        self.cameraName = cameraName
        self.time = time
        self.cameraIdx = cameraIdx
    }
    var image: UIImage?
    var cameraName: String
    var time: String
    var cameraIdx: String
}

class CameraCollectionViewCell: UICollectionViewCell {
    
    var cameraIdx: String!
    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    class var identifier: String { return String.className(self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
    
    class func size() -> CGSize {
        return CGSize(width: 135, height: 135)
    }
    
    func setData(_ data: Any?) {
        if let data = data as? CameraCollectionViewCellData {
            self.cameraImageView.image = data.image
            self.cameraNameLabel.setStrokedText(text: data.cameraName)
            self.timeLabel.setStrokedText(text: data.time)
            self.cameraIdx = data.cameraIdx
            self.indicator.isHidden = true
        }
    }

}
