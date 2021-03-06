//
//  CameraMenuViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

enum RightMenu: Int {
    case close = 0
    case cameraList
    case fourChennel
    case eightChennel
    case cameraListChennel
    case gellery
}

protocol RightMenuProtocol : class {
    func changeViewController(_ menu: RightMenu)
}

class CameraMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["", "카메라 뷰어", "4ch 카메라 뷰어", "8ch 카메라 뷰어", "리스트 카메라 뷰어", "갤러리 뷰어"]
    var mainViewController: UIViewController!
    var fourChViewController: UIViewController!
    var eightChViewController: UIViewController!
    var cameraListChViewController: UIViewController!
    var galleryViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fourChViewController = storyboard.instantiateViewController(withIdentifier: "FourChannelCameraViewController") as! FourChannelCameraViewController
        self.fourChViewController = UINavigationController(rootViewController: fourChViewController)
        
        let eightChViewController = storyboard.instantiateViewController(withIdentifier: "EightChannelCameraViewController") as! EightChannelCameraViewController
        self.eightChViewController = UINavigationController(rootViewController: eightChViewController)
        
        let cameraListChViewController = storyboard.instantiateViewController(withIdentifier: "CameraListChannelViewController") as! CameraListChannelViewController
        self.cameraListChViewController = UINavigationController(rootViewController: cameraListChViewController)
        
        let galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        self.galleryViewController = UINavigationController(rootViewController: galleryViewController)
        
        self.tableView.registerCellNib(ButtonTableViewCell.self)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorColor = AppConfigure.sharedInstance.appSkin.tableSeparatorColor()
        self.tableView.backgroundColor = AppConfigure.sharedInstance.appSkin.userMenuViewBackgrounColor()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CameraMenuViewController : RightMenuProtocol {
    func changeViewController(_ menu: RightMenu) {
        switch menu {
        case .fourChennel:
            self.slideMenuController()?.changeMainViewController(self.fourChViewController, close: true)
        case .eightChennel:
            self.slideMenuController()?.changeMainViewController(self.eightChViewController, close: true)
        case .cameraListChennel:
            self.slideMenuController()?.changeMainViewController(self.cameraListChViewController, close: true)
        case .gellery:
            self.slideMenuController()?.changeMainViewController(self.galleryViewController, close: true)
        default:
            return
        }
    }
}

extension CameraMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = RightMenu(rawValue: indexPath.row) {
            switch menu {
            case .close:
                return ButtonTableViewCell.height()+UIApplication.shared.statusBarFrame.height
            case .cameraList, .fourChennel, .eightChennel, .cameraListChennel, .gellery:
                return ButtonTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = RightMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension CameraMenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let menu = RightMenu(rawValue: indexPath.row) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier) as! ButtonTableViewCell
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.backgroundColor = UIColor.clear
            
            cell.cellTextLabel.textColor = AppConfigure.sharedInstance.appSkin.cameraMenuFontColor()
            cell.cellImageView.tintColor = AppConfigure.sharedInstance.appSkin.iconsNormalTintColor()
            
            var data: ButtonTableViewCellData?
            switch menu {
            case .close:
                data = ButtonTableViewCellData(image: nil, text: menus[indexPath.row])
            case .cameraList:
                data = ButtonTableViewCellData(image: AppConfigure.sharedInstance.appSkin.fourCameraChannelIcon(), text: menus[indexPath.row])
            case .fourChennel, .eightChennel, .cameraListChennel:
                data = ButtonTableViewCellData(image: nil, text: menus[indexPath.row])
                cell.backgroundColor = AppConfigure.sharedInstance.appSkin.otherChannelBackgroundColor()
            case .gellery:
                data = ButtonTableViewCellData(image: AppConfigure.sharedInstance.appSkin.galleryIcon(), text: menus[indexPath.row])
            }
            cell.setData(data!)
            return cell
        }
        return UITableViewCell()
    }
    
    
}
