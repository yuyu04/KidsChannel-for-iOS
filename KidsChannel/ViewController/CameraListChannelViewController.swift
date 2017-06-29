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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isWaiting = false
    var cameraList = [Camera]()
    var item = [Camera]()
    var searchCount: (start: Int, last: Int) = (start: 0, last: 20)
    var initializeViewCount: Int = 8
    var moreListCount: Int = 2
    
    fileprivate var cache = NSCache<NSURL, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UI_USER_INTERFACE_IDIOM() == .pad) {
            self.initializeViewCount = 15
            self.moreListCount = 3
        }

        let nib = UINib(nibName: CameraCollectionViewCell.identifier, bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: CameraCollectionViewCell.identifier)
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Set custom indicator
        collectionView?.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        
        // Set custom indicator margin
        collectionView?.infiniteScrollIndicatorMargin = 40
        
        collectionView?.setShouldShowInfiniteScrollHandler { _ -> Bool in
            return self.searchCount.start < self.searchCount.last && AppConfigure.sharedInstance.isLoginUser
        }
        
        guard let collectionViewInset = self.collectionView?.contentInset else {
            return
        }
        
        let top = self.topLayoutGuide.length;
        let newInsets = UIEdgeInsetsMake(top+10, 10, collectionViewInset.bottom, 10);
        self.collectionView?.contentInset = newInsets;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
        
        self.setNavigationBarItem()
        
        if AppConfigure.sharedInstance.isLoginUser == false {
            let alertController = UIAlertController(title: "알림",
                                                    message: "로그인이 필요한 서비스 입니다.",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let cacelAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel) { (result) in
                AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
            }
            alertController.addAction(cacelAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        // load initial data
        collectionView?.beginInfiniteScroll(true)
        
        self.cameraList = AppConfigure.sharedInstance.cameras
        
        self.searchCount = (start: self.item.count, last: self.item.count+self.initializeViewCount)
        
        // Add infinite scroll handler
        collectionView?.addInfiniteScroll { [weak self] (scrollView) -> Void in
            self?.searchCameraStream() {
                scrollView.finishInfiniteScroll()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func streamForUrl(cameras: [Camera], _ completion: ((Void) -> Void)?) {
        if self.searchCount.start >= self.searchCount.last {
            completion?()
        }
        
        guard let slice = cameras.slice(from: self.searchCount) else {
            return
        }
        
        // create new index paths
        let cameraCount = item.count
        let (start, end) = (cameraCount, slice.count + cameraCount)
        let indexPaths = (start..<end).map { return IndexPath(row: $0, section: 0) }
        
        let lastCount = (self.searchCount.last+self.moreListCount) > cameras.count ? cameras.count:self.searchCount.last+self.moreListCount
        self.searchCount = (start: self.searchCount.last, last: lastCount)
        
        if self.collectionView?.numberOfItems(inSection: 0) != cameraCount {
            return
        }
        
        self.item.append(contentsOf: slice)
        
        self.collectionView?.performBatchUpdates({ () -> Void in
            self.collectionView?.insertItems(at: indexPaths)
        }, completion: { (finished) -> Void in
            completion?()
        })
        
        /*CameraManager.getStreamForPlay(cameraList: slice) { (streamList) in
            
        }*/
    }
    
    func searchCameraStream(_ handler: ((Void) -> Void)?) {
        if self.cameraList.count < 1 {
            CameraManager.searchForCameraList() { (cameraList) in
                self.cameraList = cameraList
                AppConfigure.sharedInstance.cameras = cameraList
                self.streamForUrl(cameras: cameraList) { () in
                    handler?()
                }
            }
        } else {
            self.streamForUrl(cameras: self.cameraList) { () in
                handler?()
            }
        }
    }
    
    
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
        var itemWidth = collectionWidth / 2 - 15;
        
        if(UI_USER_INTERFACE_IDIOM() == .pad) {
            itemWidth = collectionWidth / 3 - 15;
        }
        
        return CGSize(width: itemWidth, height: itemWidth-10);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: - UICollectionViewDelegate
extension CameraListChannelViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fullCameraViewController = storyboard.instantiateViewController(withIdentifier: "FullCameraViewController") as! FullCameraViewController
        fullCameraViewController.camera = cameraList[indexPath.row]
        fullCameraViewController.delegate = self
        //OrientationManager.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
        OrientationManager.lockOrientation(.landscapeRight)
        self.present(fullCameraViewController, animated: true) { () in
            
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CameraListChannelViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let camera = item[indexPath.row]
        let imageUrl: URL? = URL(string: camera.cameraCaptureUrl)
        var image: UIImage?
        
        if imageUrl != nil {
            image = cache.object(forKey: imageUrl! as NSURL)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CameraCollectionViewCell.identifier, for: indexPath) as! CameraCollectionViewCell
        cell.backgroundColor = UIColor.clear
        let data = CameraCollectionViewCellData(image: image, cameraName: camera.name, time: camera.updateTime, cameraIdx: camera.idx)
        cell.setData(data)
        
        if image == nil && imageUrl != nil {
            downloadPhoto(imageUrl!, completion: { (url, image) -> Void in
                collectionView.reloadItems(at: [indexPath])
            })
        }
        
        return cell
    }
}

extension CameraListChannelViewController: FullCameraViewControllerDelegate{
    func fullCameraViewControllerDidFinish(_ fullCameraViewController: FullCameraViewController) {
        OrientationManager.lockOrientation(.portrait, andRotateTo: .portrait)
        dismiss(animated: false) { () in
        }
    }
}
