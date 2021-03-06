//
//  VersionInfoViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class VersionInfoViewController: UIViewController {

    @IBOutlet weak var versionInfo: UILabel!
    @IBOutlet weak var environment: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var versionString = "버전 "
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionString.append(version)
        } else {
            versionString.append("1.0")
        }
        versionInfo.text = versionString
        environment.text = "지원환경 iOS 9.0 이상"
        versionInfo.setRoundAndShadow()
        environment.setRoundAndShadow()
        
        confirmButton.setRoundAndShadow()
        confirmButton.backgroundColor = AppConfigure.sharedInstance.appSkin.userMenuButtonColor1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.setBackgroundPatternImage(isMainView: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: Any) {
        AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
    }
}
