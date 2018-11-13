//
//  InfoViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/6.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseFirestore

class InfoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    

    let infoArray = ["Profile Photo", "Edit Name", "WeChat ID", "My QR Code", "More"]


    @IBOutlet weak var infoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTableView.delegate = self
        infoTableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Tableview manipoplution
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        cell.textLabel?.text = infoArray[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRow = infoArray[indexPath.row]
        //performSegue(withIdentifier: selectedRow, sender: self)
        if selectedRow == "Edit Name"{
            performSegue(withIdentifier: "Edit Name", sender: self)
        }else if selectedRow == "Profile Photo"{
            performSegue(withIdentifier: "Profile Photo", sender: self)
        }else if selectedRow == "More"{
            performSegue(withIdentifier: "More", sender: self)
        }
        print(selectedRow)
    }

//END of class
}
