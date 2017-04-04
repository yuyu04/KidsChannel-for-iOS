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
    case fourChennel
    case eightChennel
    case eighteenChennel
    case gellery
}

protocol RightMenuProtocol : class {
    func changeViewController(_ menu: RightMenu)
}

class CameraMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["", "4ch 카메라 뷰어", "8ch 카메라 뷰어", "18ch 카메라 뷰어", "갤러리 뷰어"]
    var mainViewController: UIViewController!
    var fourChViewController: UIViewController!
    var eightChViewController: UIViewController!
    var sixteenChViewController: UIViewController!
    var galleryViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        //self.tableView.backgroundColor = UIColor.clear
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fourChViewController = storyboard.instantiateViewController(withIdentifier: "FourChannelCameraViewController") as! FourChannelCameraViewController
        self.fourChViewController = UINavigationController(rootViewController: fourChViewController)
        
        let eightChViewController = storyboard.instantiateViewController(withIdentifier: "EightChannelCameraViewController") as! EightChannelCameraViewController
        self.eightChViewController = UINavigationController(rootViewController: eightChViewController)
        
        let sixteenChViewController = storyboard.instantiateViewController(withIdentifier: "SixteenChannelCameraViewController") as! SixteenChannelCameraViewController
        self.sixteenChViewController = UINavigationController(rootViewController: sixteenChViewController)
        
        let galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        self.galleryViewController = UINavigationController(rootViewController: galleryViewController)
        
        self.tableView.registerCellNib(ButtonTableViewCell.self)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
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
        case .eighteenChennel:
            self.slideMenuController()?.changeMainViewController(self.sixteenChViewController, close: true)
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
            case .fourChennel, .eightChennel, .eighteenChennel, .gellery:
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
            let data = ButtonTableViewCellData(imageName: menus[indexPath.row], text: menus[indexPath.row])
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            
            switch menu {
            case .close, .fourChennel, .eightChennel, .eighteenChennel, .gellery:
                cell.setData(data)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
