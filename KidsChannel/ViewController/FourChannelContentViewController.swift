//
//  FourChannelContentViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 3..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class FourChannelContentViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var collectionOfViews: [UIView]!
    
    var pageIndex: Int!
    var camerasList: [URL]?
    var cameraView: [CameraView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let list = camerasList else {
            return
        }
        
        for i in 0 ..< list.count  {
            let cameraUrl = list[i]
            //collectionOfViews[i].backgroundColor = UIColor(hex: "000000")
            let cv = CameraView(cameraUrl: cameraUrl, view: collectionOfViews[i])
            cv.startPlay()
            cameraView?.append(cv)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
