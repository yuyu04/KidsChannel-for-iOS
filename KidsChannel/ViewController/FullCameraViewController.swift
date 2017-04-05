//
//  FullCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 5..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class FullCameraViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cameraUrl: URL?
    var cameraView: CameraView?
    
    @IBOutlet weak var screenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.shouldRotate = true
        
        guard let url = cameraUrl else {
            return
        }
        
        cameraView = CameraView(cameraUrl: url, view: screenView)
        cameraView?.startPlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.shouldRotate = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        appDelegate.shouldRotate = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordScreen(_ sender: Any) {
    }
    
    @IBAction func close(_ sender: Any) {
    }
}
