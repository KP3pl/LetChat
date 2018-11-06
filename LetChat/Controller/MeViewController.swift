//
//  MeViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/6.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit


class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var settingPageTableView: UITableView!
    
    let settingArray = ["Favorites","My Posts", "Cards N Offers", "Sticker Gallery"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingPageTableView.delegate = self
        settingPageTableView.dataSource = self
        settingPageTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
    }
    
    //MARK: - TableView manipulation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else if section == 2{
            return settingArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingPageCell", for: indexPath)
        
        if indexPath.section == 0{
            cell.textLabel?.text = "Nickname"
            cell.imageView?.image = UIImage(named: "avatarImg")
        }else if indexPath.section == 1{
            cell.textLabel?.text = "Wallet"
            cell.imageView?.image = UIImage(named: "wallet")
        }else if indexPath.section == 2{
            cell.textLabel?.text = settingArray[indexPath.row]
            cell.imageView?.image = UIImage(named: settingArray[indexPath.row])
        }else if indexPath.section == 3{
            cell.textLabel?.text = "Setting"
            cell.imageView?.image = UIImage(named: "setting")
        }

        return cell
    }
    

    //END of class
}
