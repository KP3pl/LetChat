//
//  ChatListViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/2.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var testVieew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        isX()
    }
    
    func isX() -> Bool{
        if UIScreen.main.bounds.height == 812{
          
            return true
        }
        return false
    }
    
    
    

   

}
