//
//  GalleyViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var videoModels = [AlbumVideoModel]()
    var cellArray = [GalleryTableViewCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerCellNib(GalleryTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
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
        if (isExistCell != nil) {
            cell = cellArray[indexPath.row]
        }
        
        if cell == nil {
            let iconImage = AppConfigure.sharedInstance.appSkin.galleryVideoBasicIcon()
            cell = self.tableView.dequeueReusableCell(withIdentifier: GalleryTableViewCell.identifier) as! GalleryTableViewCell
            let data = GalleryTableViewCellData(image: iconImage, title: video.creationDate, duration: video.duration)
            AlbumVideoModel.getAVAsset(from: video.asset) { (avAsset, avAudioMix, dict) in
                if self.cellArray.count < indexPath.row {
                    return
                }
                
                guard let thumbNailImage = AlbumVideoModel.getThumbnail(from: avAsset) else {
                    return
                }
                
                self.cellArray[indexPath.row].cellImageView.image = thumbNailImage
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            cell!.setData(data)
            cellArray.append(cell!)
        }
        
        return cell!
    }
    
    
}
