//
//  UserMenuViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

enum LeftMenu: Int {
    case login = 0
    case cameraInfo
    case skinSelection
    case versionInfo
    case mainView = 100
    case joinView
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class UserMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var menus = ["로그인", "회원정보", "카메라 정보", "스킨 선택", "버전 정보"]
    var mainViewController: UIViewController!
    var loginViewController: UIViewController!
    var userInfoViewController: UIViewController!
    var cameraInfoViewController: UIViewController!
    var skinSelectionViewController: UIViewController!
    var versionInfoViewController: UIViewController!
    
    var userJoinViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.loginViewController = UINavigationController(rootViewController: loginViewController)
        
        let userInfoViewController = storyboard.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        self.userInfoViewController = UINavigationController(rootViewController: userInfoViewController)
        
        let cameraInfoViewController = storyboard.instantiateViewController(withIdentifier: "CameraInfoViewController") as! CameraInfoViewController
        self.cameraInfoViewController = UINavigationController(rootViewController: cameraInfoViewController)
        
        let skinSelectionViewController = storyboard.instantiateViewController(withIdentifier: "SkinSelectionViewController") as! SkinSelectionViewController
        self.skinSelectionViewController = UINavigationController(rootViewController: skinSelectionViewController)
        
        let versionInfoViewController = storyboard.instantiateViewController(withIdentifier: "VersionInfoViewController") as! VersionInfoViewController
        self.versionInfoViewController = UINavigationController(rootViewController: versionInfoViewController)
        
        let userJoinViewController = storyboard.instantiateViewController(withIdentifier: "UserJoinViewController") as! UserJoinViewController
        self.userJoinViewController = UINavigationController(rootViewController: userJoinViewController)
        
        AppConfigure.sharedInstance.leftMenuDelegate = self
        
        self.tableView.registerCellNib(ButtonTableViewCell.self)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppConfigure.sharedInstance.isLoginUser, let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId") {
            imageHeaderView.userId.text = userId
        } else {
            imageHeaderView.userId.text = ""
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UserMenuViewController : LeftMenuProtocol {
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .login where AppConfigure.sharedInstance.isLoginUser:
            self.slideMenuController()?.changeMainViewController(self.userInfoViewController, close: true)
        case .login:
            self.slideMenuController()?.changeMainViewController(self.loginViewController, close: true)
        case .cameraInfo:
            self.slideMenuController()?.changeMainViewController(self.cameraInfoViewController, close: true)
        case .skinSelection:
            self.slideMenuController()?.changeMainViewController(self.skinSelectionViewController, close: true)
        case .versionInfo:
            self.slideMenuController()?.changeMainViewController(self.versionInfoViewController, close: true)
        case .mainView:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .joinView:
            self.slideMenuController()?.changeMainViewController(self.userJoinViewController, close: true)
        }
    }
}

extension UserMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .login, .cameraInfo, .skinSelection, .versionInfo:
                return ButtonTableViewCell.height()
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension UserMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier) as! ButtonTableViewCell
            var data: ButtonTableViewCellData!
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            switch menu {
            case .login where AppConfigure.sharedInstance.isLoginUser:
                data = ButtonTableViewCellData(imageName: menus[indexPath.row], text: menus[indexPath.row+1])
            case .login:
                data = ButtonTableViewCellData(imageName: menus[indexPath.row], text: menus[indexPath.row])
            case .cameraInfo, .skinSelection, .versionInfo:
                data = ButtonTableViewCellData(imageName: menus[indexPath.row], text: menus[indexPath.row+1])
            default:
                data = nil
            }
            cell.setData(data)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
