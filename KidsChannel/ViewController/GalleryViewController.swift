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
        self.setNavigationBarItem()
        
        if playerViewController != nil {
            // The view reappeared as a results of dismissing an AVPlayerViewController.
            // Perform cleanup.
            PlaybackManager.sharedManager.setContentForPlayback(nil)
            playerViewController?.player = nil
            playerViewController = nil
        }
        
        videoModels = AlbumVideoModel.listAlbumVideoModel()
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
