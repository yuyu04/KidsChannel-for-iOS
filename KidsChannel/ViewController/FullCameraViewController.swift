//
//  FullCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 5..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import ReplayKit

protocol FullCameraViewControllerDelegate {
    func fullCameraViewControllerDidFinish(_ fullCameraViewController: FullCameraViewController)
}

class FullCameraViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var camera: Camera?
    var cameraView: CameraView?
    var delegate: FullCameraViewControllerDelegate?
    var recordStartTime: Date?
    var viewStartTime: Date?
    
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var recordStartButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.shouldRotate = true
        
        guard let camera = camera else {
            return
        }
        
        cameraView = CameraView(camera: camera, view: screenView)
        indicatorView.startAnimating()
        cameraView?.startPlay()
        cameraView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.shouldRotate = true
        guard let isPlaying = cameraView?.isPlayerPlaying() else {
            return
        }
        
        viewStartTime = Date()
        if isPlaying == false {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            cameraView?.startPlay()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let cameraIdx = self.camera?.idx,
            let viewStartTime = self.viewStartTime else { return }
        NetworkManager.requestViewWatch(userId: userId, cameraIdx: cameraIdx, viewStartTime: viewStartTime, viewEndTime: Date())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordingStartAfterProcess(error: Error?, sender: UIButton) {
        if let unwrappedError = error {
            print(unwrappedError.localizedDescription)
        } else {
            print("start Recording")
            sender.removeTarget(self, action: #selector(startRecordScreen(_:)), for: .touchUpInside)
            sender.addTarget(self, action: #selector(stopRecordScreen(_:)), for: .touchUpInside)
            sender.setImage(UIImage(named: "ic_record_stop")!, for: .normal)
        }
    }
    
    @IBAction func startRecordScreen(_ sender: UIButton) {
        recordStartTime = Date()
        
        let record = RPScreenRecorder.shared()
        
        if #available(iOS 10.0, *) {
            record.startRecording{ [unowned self] (error) in
                self.recordingStartAfterProcess(error: error, sender: sender)
            }
        } else {
            record.startRecording(withMicrophoneEnabled: true) { (error) in
                self.recordingStartAfterProcess(error: error, sender: sender)
            }
        }
    }
    
    @IBAction func stopRecordScreen(_ sender: UIButton) {
        let recorder = RPScreenRecorder.shared()
        
        recorder.stopRecording() { (preview, error) in
            //self.cameraView?.stopPlay()
            
            sender.removeTarget(self, action: #selector(self.stopRecordScreen(_:)), for: .touchUpInside)
            sender.addTarget(self, action: #selector(self.startRecordScreen(_:)), for: .touchUpInside)
            sender.setImage(UIImage(named: "ic_record_start")!, for: .normal)
            
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self
                self.present(unwrappedPreview, animated: true) { () in
                    //self.cameraView?.startPlay()
                }
            }
        }
        
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            let cameraIdx = self.camera?.idx,
            let recordStartTime = self.recordStartTime else { return }
        NetworkManager.requestViewRecord(userId: userId, cameraIdx: cameraIdx, recordStartTime: recordStartTime, recordEndTime: Date())
    }
    
    @IBAction func close(_ sender: Any) {
        self.cameraView?.stopPlay()
        delegate?.fullCameraViewControllerDidFinish(self)

    }
}

extension FullCameraViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
}

extension FullCameraViewController: CameraViewDelegate {
    func cameraView(didTapFullScreenMode cameraView: CameraView) {
        return
    }
    
    func cameraView(didFinishLoading cameraView: CameraView) {
        self.indicatorView.stopAnimating()
        self.indicatorView.isHidden = true        
    }
}
