//
//  FourChannelCameraViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 29..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class FourChannelCameraViewController: UIViewController {

    var pageController: UIPageViewController?
    var pageContent = [[URL]]()
    var cameras: [Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchCameraStreamUrl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    func searchCameraStreamUrl() {
        CameraManager.searchForCameraList() { (cameraList) in
            self.cameras = cameraList
            CameraManager.getStreamForPlay(cameraList: cameraList) { (streamUrlList) in
                var list = [URL]()
                for streamUrl in streamUrlList {
                    list.append(streamUrl)
                    if list.count >= 4 {
                        self.pageContent.append(list)
                        list.removeAll()
                    }
                }
                
                if list.count > 0 {
                    self.pageContent.append(list)
                    list.removeAll()
                }
                self.settingViewControllers()
            }
        }
    }
    
    func settingViewControllers() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.delegate = self
        self.pageController?.dataSource = self
        
        guard let startingViewController: FourChannelContentViewController = self.viewControllerAtIndex(index: 0) else {
            return
        }
        
        let viewControllers = [startingViewController]
        self.pageController!.setViewControllers(viewControllers as [UIViewController], direction: .forward, animated: false, completion: nil)
        pageController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(self.pageController!)
        self.view.addSubview(self.pageController!.view)
        
        let pageViewRect = self.view.bounds
        self.pageController!.view.frame = pageViewRect
        self.pageController!.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index:Int) -> FourChannelContentViewController? {
        if self.pageContent.count == 0 || index >= self.pageContent.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "FourChannelContentViewController") as! FourChannelContentViewController
        dataViewController.pageIndex = index
        dataViewController.camerasList = pageContent[index]
        
        return dataViewController
    }
    
    /*func indexOfViewController(viewController: FourChannelContentViewController) -> Int {
        guard let list = viewController.camerasList else {
            return NSNotFound
        }
        
        let index = self.pageContent.index(where: { (item) -> Bool in
            item[0] == list[0]
        })
        
        if index != nil {
            return index!
        }
        
        return NSNotFound
    }*/
}

extension FourChannelCameraViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //var index = self.indexOfViewController(viewController: viewController as! FourChannelContentViewController)
        let controller = viewController as! FourChannelContentViewController
        var index = controller.pageIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //var index = self.indexOfViewController(viewController: viewController as! FourChannelContentViewController)
        let controller = viewController as! FourChannelContentViewController
        var index = controller.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == self.pageContent.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension FourChannelCameraViewController: UIPageViewControllerDelegate {
    
}
