//
//  CameraInfoViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class CameraInfoViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var cameras = [Camera]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerCellNib(CameraListTableViewCell.self)
        self.tableView.separatorColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.setBackgroundImage(isUserMenusView: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        
        guard let userId = AppConfigure.sharedInstance.userDefaults.string(forKey: "UserId"),
            AppConfigure.sharedInstance.isLoginUser,
            cameras.count == 0 else {
                return
        }
        
        self.showLoadingView()
        NetworkManager.requestCameraSearch(userId: userId) { (cameraArray) in
            self.dismissLoadingView()
            
            guard let cameraList = cameraArray else {
                return
            }
            
            self.cameras = cameraList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: Any) {
        DispatchQueue.main.async {
            AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
        }
    }
}

extension CameraInfoViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CameraListTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension CameraInfoViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cameras.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame:CGRect (x: 0, y: 0, width: tableView.frame.size.width, height: 20) ) as UIView
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let camera: Camera = cameras[indexPath.section] else {
            return UITableViewCell()
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CameraListTableViewCell.identifier) as! CameraListTableViewCell
        let cameraUrl = camera.ip + ":" + camera.port
        let data = CameraListTableViewCellData(image: AppConfigure.sharedInstance.appSkin.cameraInfoListIcon(), cameraName: camera.name, cameraUrl: cameraUrl, cameraId: camera.id)
        cell.setData(data)
        
        return cell
    }
}
