//
//  UIViewControllerExtension.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/19/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setNavigationBarItem() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppConfigure.sharedInstance.appSkin.navigationBarImage()
        self.navigationItem.titleView = imageView
        
        self.addLeftBarButtonWithImage(AppConfigure.sharedInstance.appSkin.navigationLeftButtonImage())
        self.addRightBarButtonWithImage(AppConfigure.sharedInstance.appSkin.navigationRightButtonImage())
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func setBackgroundImage(isUserMenusView: Bool) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        if isUserMenusView {
            backgroundImage.image = AppConfigure.sharedInstance.appSkin.userMenuViewsBackgroundImage()
        } else {
            
        }
        
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func showAlertView(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "",
                                                    message: message,
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let cacelAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cacelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showLoadingView() {
        DispatchQueue.main.async {
            let nib = UINib(nibName: "AlertLoadingView", bundle: nil)
            let customAlert = nib.instantiate(withOwner: self, options: nil).first as! AlertLoadingView
            
            customAlert.tag = 12345
            customAlert.title.text = "Loading"
            customAlert.indicator.startAnimating()
            
            let screen = UIScreen.main.bounds
            customAlert.frame = screen
            
            self.view.addSubview(customAlert) 
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            if let view = self.view.viewWithTag(12345) {
                view.removeFromSuperview()
            }
        }
    }
}
