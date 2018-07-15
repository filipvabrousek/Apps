//
//  ImportViewController.swift
//  Filtery
//
//  Created by Filip Vabroušek on 14.07.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Photos

class ImportViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate { // PICKER delegate
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var assets: PHAssetCollection = PHAssetCollection()
    var photosAsset: PHFetchResult<AnyObject>!
    var thumbnailSize: CGSize!
    let picker = UIImagePickerController()
    var arr = [PHAsset]() // fill in
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PHFetchOptions()
        // let collection: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        let all = PHAsset.fetchAssets(with: .image, options: options)
        
        for el in 0..<all.count{
            let a = all[el]
            arr.append(a)
        }
        
        /*
         if let first: AnyObject = collection.object(at: 2) {
         self.assets = first as! PHAssetCollection
         }*/
        
        // DANGEROUS GETTING ALBUM !!!!! Might not exist
        
        print(arr.count)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0 // remove spacing
        layout.minimumLineSpacing = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.photosAsset = (PHAsset.fetchAssets(in: self.assets, options: nil) as AnyObject?) as! PHFetchResult<AnyObject>?
        self.collectionView.reloadData()
        
    }
    
    
    
    /*---------------2--------------------------------------------COLLECTIONVIEW---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
        
    }
    
    var pass:UIImage? = nil
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PCell", for: indexPath) as! PhotoCell
        let asset = self.arr[indexPath.row]
        
        let size = CGSize(width: cell.bounds.width, height:cell.bounds.height)
        var res = UIImage()
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (result, info) in
            if result != nil {
                res = result!
            }
        }
        cell.imgView.image = res
        pass = res
        
        return cell
    }
    
   
    
    
    
    
    
    /*---------------3--------------------------------------------SEGUES---------------------------------------------------------
     */
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = arr[indexPath.row]
        let size = CGSize(width: 200, height:200)
        var res = UIImage()
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (result, info) in
            if result != nil {
                res = result!
            }
        }
        
        self.pass = res
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let edit = segue.destination as! EditViewController
            edit.img = self.pass!
        }
    }
    
    
    
    @IBAction func shot(_ sender: Any) {
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let picked = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("Taken: \(picked)")
        
        self.pass = picked
        
        picker.dismiss(animated: false, completion: nil)
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    
}
