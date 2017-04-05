//
//  EightChannelContentViewControllerViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 5..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class EightChannelContentViewController: UIViewController {

    @IBOutlet var collectionOfViews: [UIView]!
    
    var pageIndex: Int!
    var camerasList: [URL]?
    var cameraView = [CameraView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let list = camerasList else {
            return
        }
        
        for i in 0 ..< list.count  {
            let cameraUrl = list[i]
            let cv = CameraView(cameraUrl: cameraUrl, view: collectionOfViews[i])
            cameraView.append(cv)
            cameraView[i].startPlay()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
