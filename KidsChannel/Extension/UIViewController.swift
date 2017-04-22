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
        self.navigationController?.navigationBar.isTranslucent = false
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 18))
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppConfigure.sharedInstance.appSkin.navigationBarImage()
        self.navigationItem.titleView = imageView
        
        //self.addLeftBarButtonWithImage(AppConfigure.sharedInstance.appSkin.navigationLeftButtonImage())
        //self.addRightBarButtonWithImage(AppConfigure.sharedInstance.appSkin.navigationRightButtonImage())
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(AppConfigure.sharedInstance.appSkin.navigationLeftButtonImage().withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor(hex: "42392d")
        leftButton.addTarget(self, action: #selector(self.toggleLeft), for: .touchUpInside)
        leftButton.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(AppConfigure.sharedInstance.appSkin.navigationRightButtonImage().withRenderingMode(.alwaysTemplate), for: .normal)
        rightButton.addTarget(self, action: #selector(self.toggleRight), for: .touchUpInside)
        rightButton.tintColor = UIColor(hex: "42392d")
        rightButton.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButton
        
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
    
    func setBackgroundPatternImage(isMainView: Bool) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        let patternImage = UIImageView(frame: self.view.bounds)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        patternImage.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImage.contentMode = .scaleAspectFit
        patternImage.contentMode = .scaleToFill
        self.view.insertSubview(patternImage, at: 0)
        patternImage.addSubview(backgroundImage)
        
        let leadingConstraint = NSLayoutConstraint(item: patternImage, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: patternImage, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: patternImage, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: patternImage, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        let leadingConstraint2 = NSLayoutConstraint(item: backgroundImage, attribute: .leading, relatedBy: .equal, toItem: patternImage, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint2 = NSLayoutConstraint(item: backgroundImage, attribute: .trailing, relatedBy: .equal, toItem: patternImage, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint2 = NSLayoutConstraint(item: backgroundImage, attribute: .top, relatedBy: .equal, toItem: patternImage, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint2 = NSLayoutConstraint(item: backgroundImage, attribute: .bottom, relatedBy: .equal, toItem: patternImage, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        patternImage.addConstraints([leadingConstraint2, trailingConstraint2, topConstraint2, bottomConstraint2])

        if isMainView {
            backgroundImage.image = AppConfigure.sharedInstance.appSkin.mainBackgroundImage()
            patternImage.image = AppConfigure.sharedInstance.appSkin.mainBackgroundPatternImage()
        } else {
            backgroundImage.image = AppConfigure.sharedInstance.appSkin.userMenuViewsBackgroundImage()
            patternImage.image = AppConfigure.sharedInstance.appSkin.mainBackgroundPatternImage()
        }
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func showAlertView(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: UIAlertControllerStyle.alert)
            let cacelAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(cacelAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
            
            let screen = self.view.bounds
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
