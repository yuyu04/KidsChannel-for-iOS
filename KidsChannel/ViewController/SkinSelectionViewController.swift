//
//  SkinSelectionViewController.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import UIKit

class SkinSelectionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectionSkin: SkinNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectionSkin = SkinNumber(rawValue: AppConfigure.sharedInstance.userDefaults.integer(forKey: "AppSkin"))
        self.tableView.registerCellNib(SkinSelectionTableViewCell.self)
        self.tableView.separatorColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        
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
    
    @IBAction func changeSkin(_ sender: Any) {
        AppConfigure.sharedInstance.changeSkin(skinNumber: selectionSkin)
    }
    
    @IBAction func cancel(_ sender: Any) {
        AppConfigure.sharedInstance.leftMenuDelegate?.changeViewController(LeftMenu.mainView)
    }
}

extension SkinSelectionViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SkinSelectionTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectionSkin = SkinNumber(rawValue: indexPath.section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension SkinSelectionViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SkinNumber.count
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
        guard let skinSelect: SkinNumber = SkinNumber(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: SkinSelectionTableViewCell.identifier) as! SkinSelectionTableViewCell
        let data = SkinSelectionTableViewCellData(imageName: skinSelect.getSkinImageString(), text: "")
        cell.setData(data)
        
        return cell
    }
}
