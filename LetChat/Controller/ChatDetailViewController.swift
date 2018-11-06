//
//  ChatDetailViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/5.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet weak var inputViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var detailChatToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
        if isIphoneX() == true{
            print("true")
        }else{
            print("Not Iphone X")
        }
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        
    }
    
    func isIphoneX()-> Bool{
        if UIScreen.main.bounds.height == 812{
            self.inputViewHeight.constant = 83.0
            
            return true
        }
        return false
    }

}
