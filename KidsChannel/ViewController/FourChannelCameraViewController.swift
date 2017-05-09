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
    var cameras = [Camera]()
    var pageContent = [[Camera]]()
    var listSectionCount = 4
    var isLoadingFinish = false
    
    var testViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        self.cameras = AppConfigure.sharedInstance.cameras
        
        if AppConfigure.sharedInstance.isLoginUser {
            self.searchCameraStreamUrl()
        }
    }
    
    func streamForUrl(cameras: [Camera]) {
        self.pageContent = cameras.chunks(listSectionCount)
    }
    
    func searchCameraStreamUrl() {
        if self.cameras.count < 1 {
            self.showLoadingView()
            CameraManager.searchForCameraList() { (cameraList) in
                self.cameras = cameraList
                AppConfigure.sharedInstance.cameras = cameraList
                self.streamForUrl(cameras: cameraList)
                self.settingViewControllers()
                self.dismissLoadingView()
            }
        } else {
            self.streamForUrl(cameras: self.cameras)
            self.settingViewControllers()
        }
    }
    
    func settingViewControllers() {
        if pageController == nil {
            self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            self.pageController?.setNavigationBarItem()
            self.pageController?.view.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
            self.pageController?.delegate = self
            self.pageController?.dataSource = self
            
            guard let startingViewController: UIViewController = self.viewControllerAtIndex(index: 0) else {
                return
            }
            
            let viewControllers = [startingViewController]
            self.pageController!.setViewControllers(viewControllers as [UIViewController], direction: .forward, animated: false, completion: nil)
            self.addChildViewController(self.pageController!)
            self.view.addSubview(self.pageController!.view)
        }
        
        //let pageViewRect = self.view.bounds
        self.pageController!.view.frame = self.view.bounds
        self.pageController!.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index:Int) -> UIViewController? {
        if self.pageContent.count == 0 || index >= self.pageContent.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "FourChannelContentViewController") as! FourChannelContentViewController
        dataViewController.pageIndex = index
        dataViewController.cameraInfo = pageContent[index]
        
        return UINavigationController(rootViewController: dataViewController)
    }
    
    func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = AppConfigure.sharedInstance.appSkin.pageControllerViewBackgroundColor()
    }
}

extension FourChannelCameraViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //var index = self.indexOfViewController(viewController: viewController as! FourChannelContentViewController)
        let navigationController = viewController as! UINavigationController
        let controller = navigationController.viewControllers.first as! FourChannelContentViewController
        
        var index = controller.pageIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let navigationController = viewController as! UINavigationController
        let controller = navigationController.viewControllers.first as! FourChannelContentViewController
        
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
        self.setupPageControl()
        return pageContent.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension FourChannelCameraViewController: UIPageViewControllerDelegate {
    
}
