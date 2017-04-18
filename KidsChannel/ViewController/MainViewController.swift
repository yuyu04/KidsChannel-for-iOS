//
//  ViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBackgroundPatternImage(isMainView: true)
        
        if AppConfigure.sharedInstance.isLoginUser == false {
            let userDefaults = AppConfigure.sharedInstance.userDefaults
            guard let id = userDefaults.string(forKey: "UserId"),
                id.length > 0,
                let pw = userDefaults.string(forKey: "UserPassword"),
                pw.length > 0 else {
                    return
            }
            
            self.showLoadingView()
            NetworkManager.requestLogin(fromUserId: id, password: pw) { (kindergardenName, serverMessage) in
                if kindergardenName.isEmpty {
                    userDefaults.set("", forKey: "UserId")
                    userDefaults.set("", forKey: "UserPassword")
                    self.dismissLoadingView()
                    return
                }
                
                AppConfigure.sharedInstance.isLoginUser = true
                AppConfigure.sharedInstance.kindergartenName = kindergardenName
                userDefaults.set(id, forKey: "UserId")
                userDefaults.set(pw, forKey: "UserPassword")
                
                NetworkManager.requestCameraSearch(userId: id) { (cameras) in
                    self.dismissLoadingView()
                    
                    guard let cameraList = cameras else {
                        return
                    }
                    
                    AppConfigure.sharedInstance.cameras = cameraList
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
