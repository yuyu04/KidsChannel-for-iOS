//
//  LoginViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var searchPasswordButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, 10))
        //str.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 17), range: NSMakeRange(11, 11))
        joinButton.separateJoinBtn(string: "계정이 없으신가요?\n회원가입")
        joinButton.titleLabel?.lineBreakMode = .byWordWrapping
        joinButton.setShadow()
        loginButton.setRoundAndShadow()
        searchPasswordButton.setRoundAndShadow()
        
        // Do any additional setup after loading the view.
        self.setBackgroundImage(isUserMenusView: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        guard let id = userId.text,
            let pw = password.text else {
            return
        }
        
        self.showLoadingView()
        NetworkManager.requestLogin(fromUserId: id, password: pw) { (kindergardenName, serverMessage) in
            self.dismissLoadingView()
            if kindergardenName.isEmpty {
                AppConfigure.sharedInstance.userDefaults.set("", forKey: "UserId")
                AppConfigure.sharedInstance.userDefaults.set("", forKey: "UserPassword")
                self.showAlertView(message: serverMessage)
                return
            }
            
            self.showAlertView(message: "로그인에 성공했습니다.")
            AppConfigure.sharedInstance.isLoginUser = true
            AppConfigure.sharedInstance.kindergartenName = kindergardenName
            AppConfigure.sharedInstance.userDefaults.set(id, forKey: "UserId")
            AppConfigure.sharedInstance.userDefaults.set(pw, forKey: "UserPassword")
            self.cancel()
        }
    }
    
    @IBAction func showUserJoinView(_ sender: Any) {
        AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.joinView)
    }
    @IBAction func searchPassword(_ sender: Any) {
    }
    
    func cancel() {
        DispatchQueue.main.async {
            AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
        }
    }
}
