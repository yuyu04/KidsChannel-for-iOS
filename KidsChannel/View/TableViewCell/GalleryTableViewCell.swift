//
//  GalleryTableViewCell.swift
//  KidsChannel
//
//  Created by InkaMacAir on 2017. 4. 8..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import AVFoundation

struct GalleryTableViewCellData {
    
    init(image: UIImage, title: String, duration: String) {
        self.image = image
        self.title = title
        self.duration = duration
    }
    var image: UIImage
    var title: String
    var duration: String
}

class GalleryTableViewCell: BaseTableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var avAsset: AVAsset?
    
    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
    }
    
    override class func height() -> CGFloat {
        return 44
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? GalleryTableViewCellData {
            cellImageView.image = data.image
            titleLabel.text = data.title
            durationLabel.text = data.duration
        }
    }

}
