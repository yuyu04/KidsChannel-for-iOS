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
    var cameraView = [CameraView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let list = camerasList else {
            return
        }
        
        for i in 0 ..< list.count  {
            let cv = CameraView(cameraUrl: list[i], view: collectionOfViews[i])
            cameraView.append(cv)
            cameraView[i].startPlay()
            cameraView[i].delegate = self
        }
        
        self.setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for camera in self.cameraView  {
            camera.startPlay()
        }
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        for camera in self.cameraView  {
            camera.stopPlay()
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraint() {
        let constraint = (self.view.frame.size.height-(self.view.frame.size.width-25))/2
        topConstraint.constant = constraint
        bottomConstraint.constant = constraint
    }
}

extension FourChannelContentViewController: CameraViewDelegate {
    func cameraView(didTapFullScreenMode cameraView: CameraView) {
        for camera in self.cameraView  {
            camera.stopPlay()
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fullCameraViewController = storyboard.instantiateViewController(withIdentifier: "FullCameraViewController") as! FullCameraViewController
        fullCameraViewController.cameraUrl = cameraView.cameraUrlPath
        fullCameraViewController.delegate = self
        self.present(fullCameraViewController, animated: true) { () in
            
        }
    }
}

extension FourChannelContentViewController: FullCameraViewControllerDelegate {
    func fullCameraViewControllerDidFinish(_ fullCameraViewController: FullCameraViewController) {
        dismiss(animated: true) { () in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.shouldRotate = false
        }
    }
}
