//
//  EightChannelCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class EightChannelCameraViewController: FourChannelCameraViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.listSectionCount = 8
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllerAtIndex(index: Int) -> UIViewController? {
        if self.pageContent.count == 0 || index >= self.pageContent.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "EightChannelContentViewController") as! EightChannelContentViewController
        dataViewController.pageIndex = index
        dataViewController.cameraInfo = pageContent[index]
        
        return UINavigationController(rootViewController: dataViewController)
    }

}
