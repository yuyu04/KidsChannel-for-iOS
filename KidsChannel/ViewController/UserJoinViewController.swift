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
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var kindergartenName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        guard let _ = self.passwordConfirm.text,
            password == self.passwordConfirm.text else {
                self.showAlertView(message: "비밀번호가 일치하지 않습니다")
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
