//
//  GalleyViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos

class GalleryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var videoModels = [AlbumVideoModel]()
    var cellArray = [GalleryTableViewCell]()
    
    fileprivate var playerViewController: AVPlayerViewController?
    var avPlayer: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerCellNib(GalleryTableViewCell.self)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        PlaybackManager.sharedManager.delegate = self
        //self.tableView.contentInset = UIEdgeInsets.init(top: -36, left: 0, bottom: 0, right: 0)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.separatorColor = AppConfigure.sharedInstance.appSkin.tableSeparatorColor()
        self.view.backgroundColor = AppConfigure.sharedInstance.appSkin.galleryBackgroundColor()
        
        self.setNavigationBarItem()
        
        if playerViewController != nil {
            // The view reappeared as a results of dismissing an AVPlayerViewController.
            // Perform cleanup.
            PlaybackManager.sharedManager.setContentForPlayback(nil)
            playerViewController?.player = nil
            playerViewController = nil
        }
        
        let isConfirmAlbum = AppConfigure.sharedInstance.userDefaults.bool(forKey: "ConfirmAlbum")
        if isConfirmAlbum == false {
            self.showAlertView {
                self.checkForPhotoLibraryAccess {
                    self.videoModels = AlbumVideoModel.listAlbumVideoModel()
                    self.tableView.reloadData()
                }
            }
        } else {
            self.checkForPhotoLibraryAccess {
                self.videoModels = AlbumVideoModel.listAlbumVideoModel()
                self.tableView.reloadData()
            }
        }
    }
    
    func showAlertView(completion: ((Void) -> Void)?) {
        let alertController = UIAlertController(title: "고지",
                                                message: "갤러리 뷰어는 해당 단말기의 앨범에서 녹화된 영상을 가져오게 됩니다. 따라서 녹화된 영상을 보려면 단말기 사진에 대한 접근 허용을 하락해 주셔야 합니다.",
                                                preferredStyle: UIAlertControllerStyle.alert)
        let cacelAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel) { (result) in
            completion?()
        }
        alertController.addAction(cacelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkForPhotoLibraryAccess(andThen f:(()->())? = nil) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            AppConfigure.sharedInstance.userDefaults.set(true, forKey: "ConfirmAlbum")
            f?()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        f?()
                    }
                }
            }
        case .restricted:
            // do nothing
            break
        case .denied:
            // do nothing, or beg the user to authorize us in Settings
            AppConfigure.sharedInstance.userDefaults.set(false, forKey: "ConfirmAlbum")
            self.showAlertView(title: "알림", message: "단말기 설정에 가서 사진에 대한 접근 허용을 해주셔야 합니다")
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GalleryViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GalleryTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var cell: GalleryTableViewCell?
        if (cellArray.count > indexPath.row) {
            cell = cellArray[indexPath.row]
        }
        
        if cell != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let playerViewController = storyboard.instantiateViewController(withIdentifier: "AVPlayerViewController") as? AVPlayerViewController else {
                return
            }
            self.playerViewController = playerViewController
            
            self.present(self.playerViewController!, animated: true) { () in
                PlaybackManager.sharedManager.setContentForPlayback(cell!.avAsset)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension GalleryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let video: AlbumVideoModel = videoModels[indexPath.row] else {
            return UITableViewCell()
        }
        
        let isExistCell = cellArray.index(where: { (item) -> Bool in
            item.titleLabel.text == video.creationDate
        })
        
        var cell: GalleryTableViewCell?
        if (isExistCell != nil && cellArray.count > indexPath.row) {
            cell = cellArray[indexPath.row]
        }
        
        if cell == nil {
            let iconImage = AppConfigure.sharedInstance.appSkin.galleryVideoBasicIcon()
            cell = self.tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.identifier) as? GalleryTableViewCell
            cell?.backgroundColor = UIColor.clear
            cell?.titleLabel.textColor = AppConfigure.sharedInstance.appSkin.galleryFontColor()
            cell?.durationLabel.textColor = AppConfigure.sharedInstance.appSkin.galleryFontColor()
            let data = GalleryTableViewCellData(image: iconImage, title: video.creationDate, duration: video.duration)
            AlbumVideoModel.getAVAsset(from: video.asset) { (avAsset, avAudioMix, dict) in
                if self.cellArray.count < indexPath.row {
                    return
                }
                
                guard let thumbNailImage = AlbumVideoModel.getThumbnail(from: avAsset) else {
                    return
                }
                
                self.cellArray[indexPath.row].cellImageView.image = thumbNailImage
                self.cellArray[indexPath.row].avAsset = avAsset
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            cell!.setData(data)
            cellArray.append(cell!)
        }
        
        return cell!
    }
}

extension GalleryViewController: PlaybackDelegate {
    func playbackManager(_ playbackManager: PlaybackManager, playerReadyToPlay player: AVPlayer) {
        player.play()
    }
    
    func playbackManager(_ playbackManager: PlaybackManager, playerCurrentItemDidChange player: AVPlayer) {
        guard let playerViewController = self.playerViewController , player.currentItem != nil else { return }
        
        playerViewController.player = player
    }
    
    func playbackManager(_ playbackManager: PlaybackManager, playerFail player: AVPlayer, content: AVAsset?, error: Error?) {
        guard let playerViewController = self.playerViewController , player.currentItem != nil else { return }
        
        var message = ""
        if error != nil {
            print("Error: \(error)\n Could play the fps content")
            
            let nsErr: NSError = error as! NSError
            if let underlyingError = nsErr.userInfo[NSUnderlyingErrorKey] as? NSError, underlyingError.domain == NSOSStatusErrorDomain {
                switch underlyingError.code {
                default:
                    break
                }
            }
        }
        
        let alert = UIAlertController(title: "Play Failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { Void in
            playerViewController.dismiss(animated: true, completion: nil)
            }
        )
        playerViewController.present(alert, animated: true, completion: nil)
    }
}
