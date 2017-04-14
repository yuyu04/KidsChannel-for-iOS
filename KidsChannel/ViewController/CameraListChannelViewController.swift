//
//  EighteenChannelCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class CameraListChannelViewController: UICollectionViewController {
    
    fileprivate let downloadQueue = DispatchQueue(label: "kidsChannel.downloadQueue", qos: DispatchQoS.background)
    
    var isWaiting = false
    var cameraAllList = [Camera]()
    var cameraList = [CameraListModel]()
    var searchCount: (start: Int, last: Int) = (start: 0, last: 8)
    var cellArray = [CameraCollectionViewCell]()
    fileprivate var cache = NSCache<NSURL, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
        
        let nib = UINib(nibName: CameraCollectionViewCell.identifier, bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: CameraCollectionViewCell.identifier)
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Set custom indicator
        collectionView?.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        // Set custom indicator margin
        collectionView?.infiniteScrollIndicatorMargin = 40

        // load initial data
        collectionView?.beginInfiniteScroll(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        self.cameraAllList = AppConfigure.sharedInstance.cameras
        self.cameraList = AppConfigure.sharedInstance.cameraList
        
        if self.cameraAllList.count > 0 && self.cameraAllList.count == self.cameraList.count {
            return
        }
        
        self.searchCount = (start: self.cameraList.count, last: self.cameraList.count + 8)
        
        // Add infinite scroll handler
        collectionView?.addInfiniteScroll { [weak self] (scrollView) -> Void in
            if AppConfigure.sharedInstance.isLoginUser {
                self?.searchCameraStream() {
                    scrollView.finishInfiniteScroll()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func streamForUrl(cameras: [Camera], _ completion: ((Void) -> Void)?) {
        if self.searchCount.start == self.searchCount.last {
            completion?()
        }
        
        guard let slice = cameras.slice(from: self.searchCount) else {
            return
        }
        
        CameraManager.getStreamForPlay(cameraList: slice) { (streamList) in
            var list = [CameraListModel]()
            for stream in streamList {
                let camera = CameraListModel(camera: stream.camera, streamUrl: stream.url)
                list.append(camera)
            }
            
            // create new index paths
            let cameraCount = self.cameraList.count
            let (start, end) = (cameraCount, list.count + cameraCount)
            let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
            
            self.searchCount = (start: self.searchCount.last, last: self.searchCount.last+4)
            
            self.cameraList.append(contentsOf: list)
            AppConfigure.sharedInstance.cameraList = self.cameraList
            
            self.collectionView?.performBatchUpdates({ () -> Void in
                self.collectionView?.insertItems(at: indexPaths)
            }, completion: { (finished) -> Void in
                completion?()
            })
        }
    }
    
    func searchCameraStream(_ handler: ((Void) -> Void)?) {
        if self.cameraAllList.count < 1 {
            CameraManager.searchForCameraList() { (cameraList) in
                self.cameraAllList = cameraList
                AppConfigure.sharedInstance.cameras = cameraList
                self.streamForUrl(cameras: cameraList) { () in
                    handler?()
                }
            }
        } else {
            self.streamForUrl(cameras: self.cameraAllList) { () in
                handler?()
            }
        }
    }
    
    /*func loadMoreData() {
        self.searchCount.last = self.searchCount.start + 2
        let slice = self.cameraAllList.slice(from: self.searchCount)
        if slice.count == 0 {
            self.isWaiting = false
            return
        }
        
        CameraManager.getStreamForPlay(cameraList: slice) { (streamList) in
            self.searchCount.start = streamList.count-1
            for stream in streamList {
                let camera = CameraListModel(camera: stream.camera, streamUrl: stream.url)
                self.cameraList.append(camera)
            }
            self.isWaiting = false
        }
    }*/
    
    // MARK: - Private
    
    fileprivate func downloadPhoto(_ url: URL, completion: @escaping (_ url: URL, _ image: UIImage) -> Void) {
        downloadQueue.async(execute: { () -> Void in
            if let image = self.cache.object(forKey: url as NSURL) {
                DispatchQueue.main.async {
                    completion(url, image)
                }
                
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cache.setObject(image, forKey: url as NSURL)
                        completion(url, image)
                    }
                } else {
                    print("Could not decode image")
                }
            } catch {
                print("Could not load URL: \(url): \(error)")
            }
        })
    }
}

extension CameraListChannelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width;
        var itemWidth = collectionWidth / 2 - 1;
        
        if(UI_USER_INTERFACE_IDIOM() == .pad) {
            itemWidth = collectionWidth / 4 - 1;
        }
        
        return CGSize(width: itemWidth, height: itemWidth);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

// MARK: - UICollectionViewDelegate
extension CameraListChannelViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension CameraListChannelViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cameraList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let camera = cameraList[indexPath.row]
        let imageUrl: URL? = URL(string: camera.camera.cameraCaptureUrl)
        var image: UIImage?
        
        if imageUrl != nil {
            image = cache.object(forKey: imageUrl! as NSURL)
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CameraCollectionViewCell.identifier, for: indexPath) as! CameraCollectionViewCell
        cell.backgroundColor = UIColor.clear
        let data = CameraCollectionViewCellData(image: image, cameraName: camera.camera.name, time: "", cameraIdx: camera.camera.idx)
        cell.setData(data)
        
        if image == nil && imageUrl != nil {
            downloadPhoto(imageUrl!, completion: { (url, image) -> Void in
                collectionView.reloadItems(at: [indexPath])
            })
        }
        
        return cell
    }
}
