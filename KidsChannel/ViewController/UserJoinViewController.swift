//
//  UserAccountViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 31..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class UserJoinViewController: UIViewController {

    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var kindergartenName: UITextField!
    
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        joinButton.setRoundAndShadow()
        cancelButton.setRoundAndShadow()
        joinButton.backgroundColor = AppConfigure.sharedInstance.appSkin.userMenuButtonColor1()
        cancelButton.backgroundColor = AppConfigure.sharedInstance.appSkin.userMenuButtonColor3()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setBackgroundPatternImage(isMainView: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func joinUserAccount(_ sender: Any) {
        guard let userId = self.userId.text else {
            return
        }
        
        guard let password = self.password.text else {
            self.showAlertView(message: "비밀번호를 입력해 주세요")
            return
        }
        
        guard let kindergartenName = self.kindergartenName.text else {
            self.showAlertView(message: "유치원 이름을 입력해 주세요")
            return
        }
        
        NetworkManager.requestUserJoin(userId: userId, password: password, kindergartenName: kindergartenName) { (message) in
            if message.isEmpty {
                self.showAlertView(message: "회원정보에 성공했습니다")
                DispatchQueue.main.async {
                    AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.login)
                }
            } else {
                self.showAlertView(message: message)
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        DispatchQueue.main.async {
            AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.login)
        }
    }
}
