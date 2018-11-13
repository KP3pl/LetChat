//
//  TestViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/9.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class TestViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func uploadBtn(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        
        let alert = UIAlertController(title: "Upload", message: "Select photo", preferredStyle: .actionSheet)
        
        let imgFromLibAction = UIAlertAction(title: "Gallery", style: .default) { (Void) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imgPicker.sourceType = .photoLibrary
                self.present(imgPicker, animated: true, completion: nil)
            }
        }
        
        let imgFormCameraAction = UIAlertAction(title: "Carmera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imgPicker.sourceType = .camera
                
                self.present(imgPicker, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(imgFromLibAction)
        alert.addAction(imgFormCameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    //END
}

extension TestViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var imgFromPicker:UIImage?
        let autoID = NSUUID().uuidString
        
        if let pickedImg = info[.originalImage] as? UIImage{
            imgFromPicker = pickedImg
        }
        
        if let selectedImg = imgFromPicker{
            
            //Upload image to firestorage
            
            let storageRef = Storage.storage().reference().child("UploadImg").child(autoID)
            
            if let uploadData = selectedImg.pngData(){
                storageRef.putData(uploadData, metadata: nil) { (data, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                        return
                    }else{
                        print("Upload success")
                    }
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }else if let uploadImgUrl = url?.absoluteString{
                            print(uploadImgUrl)
                            
                            //Save upload image url to database
                            let databaseRef = Database.database().reference().child("UploadImgageUrl").child(autoID)
                            databaseRef.setValue(uploadImgUrl, withCompletionBlock: { (error, dataRef) in
                                if error != nil{
                                    print(error!.localizedDescription)
                                }else{
                                    print("URL saved")

                                }
                            })
                        }
                    })
                    
                }
            }
            
            
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //END
}
