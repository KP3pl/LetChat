//
//  ViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/1.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    

    
    //MARK: - Sign in & sign up function
    
    @IBAction func signinBtn(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: pwTextField.text!) { (user, error) in
            if error != nil{
                print(error!)
                let errorCode = (error! as NSError).code
                switch errorCode {
                case 17007:
                    self.popAlert(mgs: "The email address is already in use by another account.")
                case 17008:
                    self.popAlert(mgs: "The email address is badly formatted.")
                case 17026:
                    self.popAlert(mgs: "The password must be 6 characters long or more.")
                default:
                    self.popAlert(mgs: "Something wrong")
                }
            }else{
                print("Sign in success")
                self.performSegue(withIdentifier: "goToChatList", sender: self)
            }
        }
    }
    
    @IBAction func signupBtn(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!) { (user, error) in
            if error != nil{
                print(error!)
                let errorCode = (error! as NSError).code
                switch errorCode {
                case 17007 :
                    self.popAlert(mgs: "The email address is already in use by another account.")
                case 17008 :
                    self.popAlert(mgs: "The email address is badly formatted.")
                case 17026 :
                    self.popAlert(mgs: "The password must be 6 characters long or more.")
                default:
                    self.popAlert(mgs: "Something wrong")
                }
            
            }else{
                print("Sign up success")
                self.performSegue(withIdentifier: "goToChatList", sender: self)
            }
        }
    }
    
    //MARK: - Hidden keypad when touch the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Pop alert when error is occur
    func popAlert(mgs:String){
        let alert = UIAlertController(title: "oops", message: mgs, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    //END of class
}

