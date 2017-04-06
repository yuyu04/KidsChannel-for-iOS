//
//  FullCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 5..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import ReplayKit

class FullCameraViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cameraUrl: URL?
    var cameraView: CameraView?
    
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var recordStartButton: UIButton!
    @IBOutlet weak var recordStopButton: UIButton!
    
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
        guard let isPlaying = cameraView?.isPlayerPlaying() else {
            return
        }
        
        if isPlaying {
            cameraView?.startPlay()
        }
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
            sender.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func startRecordScreen(_ sender: UIButton) {
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
            self.cameraView?.stopPlay()
            
            sender.removeTarget(self, action: #selector(self.stopRecordScreen(_:)), for: .touchUpInside)
            sender.addTarget(self, action: #selector(self.startRecordScreen(_:)), for: .touchUpInside)
            sender.setTitle("Record", for: .normal)
            
            if let unwrappedPreview = preview {
                unwrappedPreview.previewControllerDelegate = self
                self.present(unwrappedPreview, animated: true) { () in
                    self.cameraView?.startPlay()
                }
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.cameraView?.stopPlay()
        self.dismiss(animated: true) { () in
            self.appDelegate.shouldRotate = false
        }
    }
}

extension FullCameraViewController: RPPreviewViewControllerDelegate {
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true)
    }
}
