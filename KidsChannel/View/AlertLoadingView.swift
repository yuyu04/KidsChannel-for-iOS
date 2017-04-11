//
//  AlertLoadingView.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 11..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class AlertLoadingView: UIView {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.loadingView.layoutIfNeeded()
        self.loadingView.layer.cornerRadius = 10.0
        self.loadingView.layer.borderWidth = 0.5
        self.loadingView.layer.borderColor = UIColor.gray.cgColor
        self.loadingView.clipsToBounds = true
    }
}
