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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
        self.navigationController?.navigationBar.isHidden = true
        
        self.setupConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if collectionOfViews.count == camerasList.count {
            return
        }
        
        for indicator in collectionOfIndicatorView {
            indicator.isHidden = true
        }
        
        self.setCameraView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for camera in self.cameraView  {
            camera.stopPlay()
        }
    }
    
    func setCameraView() {
        self.showLoadingView()
        CameraManager.getStreamForPlay(cameraList: cameraInfo) { (streamList) in
            self.dismissLoadingView()
            for i in 0 ..< streamList.count {
                var index = AppConfigure.sharedInstance.cameraList.index(where: {
                    $0.camera == streamList[i].camera
                })
                
                if index == nil {
                    let model = CameraListModel(camera: streamList[i].camera, streamUrl: streamList[i].url)
                    AppConfigure.sharedInstance.cameraList.append(model)
                }
                
                index = self.cameraView.index(where: { $0.camera == streamList[i].camera })
                
                if index == nil {
                    let cv = CameraView(camera: streamList[i].camera, view: self.collectionOfViews[i])
                    self.cameraView.append(cv)
                    self.cameraView[i].tag = i
                    self.cameraView[i].delegate = self
                    self.cameraView[i].cameraUrlPath = streamList[i].url
                    self.collectionOfIndicatorView[i].isHidden = false
                    self.collectionOfIndicatorView[i].startAnimating()
                } else {
                    /*if self.cameraView[index!].cameraUrlPath == nil {
                        self.cameraView[index!].setStreamUrl()
                    }*/
                    if self.cameraView[index!].isPlayerPlaying() == false {
                        self.cameraView[index!].setVideoView(view: self.collectionOfViews[index!])
                        self.cameraView[index!].setStreamUrl()
                        self.cameraView[index!].delegate = self
                        self.collectionOfIndicatorView[i].isHidden = false
                        self.collectionOfIndicatorView[i].startAnimating()
                    }
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
        OrientationManager.lockOrientation(.landscapeRight)
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
        OrientationManager.lockOrientation(.portrait, andRotateTo: .portrait)
        dismiss(animated: false) { () in
        }
    }
}
