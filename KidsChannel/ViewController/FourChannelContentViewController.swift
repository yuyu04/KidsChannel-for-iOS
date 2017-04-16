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
    @IBOutlet var collectionOfIndicatorView: [UIActivityIndicatorView]!
    
    var pageIndex: Int!
    var camerasList = [CameraListModel]()
    var cameraInfo: [Camera]!
    var cameraView = [CameraView]()
    
    let configureCameraList = AppConfigure.sharedInstance.cameraList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
        
        self.setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if collectionOfViews.count == camerasList.count {
            return
        }
        
        self.setCameraView()
    }
    
    func setCameraView() {
        for i in 0 ..< collectionOfViews.count {
            let cv = CameraView(camera: cameraInfo[i], view: self.collectionOfViews[i])
            
            let index = self.cameraView.index{$0 === cv}
            if index == nil {
                self.cameraView.append(cv)
                self.cameraView[i].tag = i
                self.cameraView[i].delegate = self
                
                self.collectionOfIndicatorView[i].isHidden = false
                self.collectionOfIndicatorView[i].startAnimating()
            } else {
                if self.cameraView[i].cameraUrlPath == nil {
                    self.cameraView[i].setStreamUrl()
                }
            }
        }
    }
    
    func setupConstraint() {
        let constraint = (self.view.frame.size.height-(self.view.frame.size.width+50))/2
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
        fullCameraViewController.camera = cameraView.camera
        fullCameraViewController.delegate = self
        self.present(fullCameraViewController, animated: true) { () in
            
        }
    }
    
    func cameraView(didFinishLoading cameraView: CameraView) {
        let tag = cameraView.tag
        if collectionOfIndicatorView.count >= tag {
            collectionOfIndicatorView[tag].isHidden = true
        }
    }
}

extension FourChannelContentViewController: FullCameraViewControllerDelegate {
    func fullCameraViewControllerDidFinish(_ fullCameraViewController: FullCameraViewController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.shouldRotate = false
        dismiss(animated: false) { () in
        }
    }
}
