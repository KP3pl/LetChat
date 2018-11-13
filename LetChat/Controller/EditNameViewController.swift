//
//  EditNameViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/7.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseFirestore

class EditNameViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var editNameTextField: UITextField!
    
    let firestoreDB = Firestore.firestore()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editNameTextField.becomeFirstResponder()
        let setting = firestoreDB.settings
        setting.areTimestampsInSnapshotsEnabled = true
        firestoreDB.settings = setting
        retrievtData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrievtData()
        btnStatus(btn: doneBtn)
    }
    
    
    //MARK: - Connet to firestone
    @IBAction func doneBtn(_ sender: UIBarButtonItem) {

        
        firestoreDB.collection("userNickName").document("nickName").setData(["name" : editNameTextField.text!]) { (error) in
            if error != nil{
                print(error!)
            }else{
                print("Set data success")
                DispatchQueue.main.async {
                    self.retrievtData()
                }
                
            }
        }
    }
    
    func retrievtData(){
         firestoreDB.collection("userNickName").getDocuments { (snapShot, error) in
            if error != nil{
                print(error!)
            }else{
                for document in snapShot!.documents{
                    print("\(document.documentID) => \(document.data())")
                    self.editNameTextField.text = document["name"] as? String
                    self.editNameTextField.endEditing(true)
                }
                
            }
        }
    }
    
    //MARK: - TextField manipupluation

    func textFieldDidEndEditing(_ textField: UITextField) {
        editNameTextField.endEditing(true)
    }
    
    func btnStatus(btn:UIBarButtonItem){
        if editNameTextField.text != ""{
            btn.isEnabled = false
            
        }else{
            btn.isEnabled = true
        }
    }

//END of class

}
