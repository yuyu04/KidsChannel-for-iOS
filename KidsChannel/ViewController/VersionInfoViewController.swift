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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: Any) {
        AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
