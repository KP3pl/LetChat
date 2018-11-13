//
//  ProfilePhotoViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/8.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class ProfilePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatarImg: UIImageView!
    
    
    let storage = Storage.storage()

    let imgPicker = UIImagePickerController()
    
    var uploadDict:[String:Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPicker.delegate = self
        // Do any additional setup after loading the view.
        

        retrieveData()
        
    }
    
    
    func retrieveData(){

        let databaseRef = Database.database().reference()

        
        databaseRef.observe(.value) { [weak self](snapshot) in
            if let uploadDataDict = snapshot.value as? [String:Any]{
                self?.uploadDict = uploadDataDict
               
                
               self?.uploadDict = uploadDataDict
                
                if let dataDict = self?.uploadDict{
                   print("\(dataDict["UploadImgUrl"]!) + get url success")
                    if let imgUrlStr = dataDict["UploadImgUrl"] as? String{
                        if let imgUrl = URL(string: imgUrlStr){
                            URLSession.shared.dataTask(with: imgUrl, completionHandler: { (data, response, error) in
                                if error != nil{
                                    print(error!.localizedDescription)
                                }else if let imgData = data{
                                    
                                    DispatchQueue.main.async {
                                        self!.avatarImg.image = UIImage(data: imgData)
                                    }
                                }
                                
                            }).resume()
                        }
                    }
                }
                
            }
        }
        print("Retrieve data")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImgFromPicker:UIImage?
        
        if let pickedImg = info[.originalImage] as? UIImage{
            selectedImgFromPicker = pickedImg
        }
        
        if let selectedImg = selectedImgFromPicker{
 
            let uniqueStr = NSUUID().uuidString
                let storageDB = Storage.storage().reference().child("UploadImg").child(uniqueStr)
                if let uploadData = selectedImg.pngData(){
                    storageDB.putData(uploadData, metadata: nil) { (metadata, error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }else{
                            print("Upload data success")
                        }
                        
                        storageDB.downloadURL(completion: { (url, error) in
                            if error != nil{
                                print(error!.localizedDescription)
                            }else{
                                //Upload the urlStr to database
                                if let uploadImgUrl = url?.absoluteString{
                                    let databaseRef = Database.database().reference().child("UploadImgUrl")
                                    databaseRef.setValue(uploadImgUrl, withCompletionBlock: { (error, dataRef) in
                                        if error != nil{
                                            print(error!.localizedDescription)
                                        }else{
                                            print("Saved link success")
                                        }
                                    })
                                }
                            }
                        })
                    }
                }
            }

  
        
       
        dismiss(animated: true, completion: nil)
    }
    

    //MARK: - TopRight menu function
    
    @IBAction func moreBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionTakePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            print("Take Photo")
            self.takePhoto()
        }
        let actionSelectedAtPhone = UIAlertAction(title: "Selected at gallery", style: .default) { (action) in
            print("Select photo")
            self .showAlbum()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(actionTakePhoto)
        alert.addAction(actionSelectedAtPhone)
        alert.addAction(actionCancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func takePhoto(){
        
        imgPicker.sourceType = .camera
        present(imgPicker, animated: true, completion: nil)
    }
    
 
    
    func showAlbum(){
        let showAlbum = UIImagePickerController()
        showAlbum.sourceType = .savedPhotosAlbum
        showAlbum.delegate = self
        present(showAlbum, animated: true, completion: nil)
    
    }

    

    //END of class
}
