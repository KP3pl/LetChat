//
//  ChatListViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/2.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var chatList = ["Apple","Mac","Iphone"]
    var mgsText = ["Hi","Hello","How are you?"]
    var timeText = ["15:30","10:11","10:09"]
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        chatListTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        self.tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    //MARK: - Tableview manipupluation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.fdName.text = chatList[indexPath.row]
        cell.avatarImg.image = UIImage(named: "avatarImg")
        cell.mgsLabel.text = mgsText[indexPath.row]
        cell.timeLabel.text = timeText[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToDetail", sender: self)
        
    }
    
    

    @IBAction func moreFunc(_ sender: UIBarButtonItem) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    

   
//END of class
}
