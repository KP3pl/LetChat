//
//  MyCollectionViewController.swift
//  LetChat
//
//  Created by 3PL-Total on 2018/11/9.
//  Copyright © 2018 KNA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyCollectionViewController: UICollectionViewController {
    
    var uploadDict:[String:Any]?
    
    @IBOutlet var myCollectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        let databaseRef = Database.database().reference().child("UploadImgageUrl")
        databaseRef.observe(.value) { (snapshot) in
            if let uploadDataDict = snapshot.value as? [String:Any]{
                self.uploadDict = uploadDataDict
                self.myCollectionView.reloadData()
            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        myCollectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections

        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let dataDict = uploadDict{
            
            return dataDict.count

        }
        return 0

        
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MyCollectionViewCell

        //Configure the cell
        if let dataDict = uploadDict{
            let keyArray = Array(dataDict.keys)
            if let imgUrlStr = dataDict[keyArray[indexPath.row]] as? String{

                if let imgUrl = URL(string: imgUrlStr){
                    let task = URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
                        if error != nil{
                            print(error!.localizedDescription)
                        }else if let imgData = data{
                            print("Get photo success")
                            DispatchQueue.main.async {
                                cell.collectionImgView.image = UIImage(data: imgData)
                            }
                        }
                    }
                    task.resume()
                }
                
            }
        }

        
    
        return cell
    }
}
