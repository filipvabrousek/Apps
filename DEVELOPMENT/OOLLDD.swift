//
//  ShareViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 22.06.18.
//  Copyright © 2018 Filip Vabroušek. All rights reserved.
//

import UIKit
import Photos

class ShareViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // variables
    var gdist = ""
    var gtime = ""
    var gpace = ""
    
    var grad:String? = "#1abc9c"
    var light:String? = "#2ecc71"
    var globalI:UIImage?
    
    var e = 0
    
    // instances
    var img: UIImage?
    var obj:Run? = nil
    let g = Generator()
    
    // arrays
    var runs = [Run]()
    var arr = [PHAsset]()
    
    
    lazy var picker: UIImagePickerController = {
        let p = UIImagePickerController()
        p.delegate = self
        p.sourceType = .camera
        return p
    }()
    
    
    let v: UIView = {
        var e = UIView()
        e.backgroundColor = hex("#f7f8f8")
        return e
    }()
    
    
    
    
    var photoLabel: UILabel = {
        var l = UILabel()
        l.text = "Photos"
        l.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.heavy) //UIFont.boldSystemFont(ofSize: 22)
        return l
    }()
    
    
    
    var imgview: UIImageView = {
        var i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    lazy var switcher: UISwitch = {
        let s = UISwitch()
        s.addTarget(self, action: #selector(self.switched(_:)), for: .valueChanged)
        return s
    }()
    
    let infol: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.text = "Gradient"
        l.textAlignment = .center
        return l
    }()
    
    
    
    
    @objc func switched(_ sender: UISwitch){
        
        
        if globalI != nil {
            
            let run = self.runs[self.e]
            let time = Time(seconds: run.duration)
            
            var write = ""
            if (run.duration < 3600){
                write = time.shortTime
            } else {
                write = time.createTime
            }
            
            let dd = run.sectionDist
            let ss = run.sectionSecs
            
            
            var i = UIImage()
            
            
            if self.switcher.isOn == false {
                self.grad = nil
                self.light = nil
            } else {
                self.grad = "#1abc9c"
                self.light = "#2ecc71"
            }
            
            if run.sectionDist != "" && run.sectionSecs != 0 {
                let km = Double(dd)!.tokm()
                
                let pace = Pace(sec: Double(ss), dist: km)
                
                
                i = g.genImage(image: globalI!, distance: run.distance, time: write, efpace: pace.getPace(), g1: self.grad, g2: self.light)
                
                self.gpace = pace.getPace()
                
                print("SHAREDIST \(run.sectionDist)  \(run.sectionSecs)")
            } else {
                // let pace = Pace(sec: Double(ss), dist: Double(dd)! / 1000.0)
                i = g.genImage(image: globalI!, distance: run.distance, time: write, efpace: "", g1: self.grad, g2: self.light)
                self.gpace = ""//pace.getPace()
            }
            
            
            
            self.imgview.image = i
        }
        
    }
    
    
    
    @objc func shot(sender: UIButton!){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            UserDefaults.standard.set(true, forKey: "blockreset")
            present(picker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    
    
    
    var navBar: UINavigationBar = {
        
        var n = UINavigationBar()
        n.backgroundColor = .white
        
        let back = UIButton()
        back.setTitle("←", for: [])
        
        let navItem = UINavigationItem(title: "")
        let doneItem = UIBarButtonItem(title: "←", style: .plain, target: nil, action: #selector(make))
        doneItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            ], for: [])
        
        
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: #selector(share))
        doneItem.tintColor = .black
        shareItem.tintColor = .black
        
        navItem.leftBarButtonItem = doneItem
        navItem.rightBarButtonItems = [shareItem]
        n.setItems([navItem], animated: false)
        n.backgroundColor = hex("#f7f8f8")
        return n
    }()
    
    
    
    lazy var ppicker: UIButton = {
        let b = UIButton()
        // b.setTitle("📷", for: [])
        b.backgroundColor = .clear
        b.setImage(UIImage(named: "camera-icon.png"), for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        b.addTarget(self, action: #selector(self.shot(sender:)), for: .touchUpInside)
        return b
    }()
    
    
    
    
    lazy var photosView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        let cw = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cw.register(PhotoCell.self, forCellWithReuseIdentifier: "pid")
        cw.delegate = self
        cw.dataSource = self
        cw.backgroundColor = .clear
        cw.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        cw.contentInset = UIEdgeInsets(top: 60, left: 10, bottom: 0, right: 10 )
        return cw
    }()
    
    
    @objc func getBack(){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func setObj(){
        obj = runs[e]
    }
    
    
    
    func setupUI(){
        view.backgroundColor = .white
    }
    
    
    /*------------------------------------------------------LIFECYCLE------------------------------------------------------*/
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setObj()
        addUI()
        constrainUI()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pid", for: indexPath) as! PhotoCell
        
        let asset = self.arr[indexPath.row]
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true // or false
        
        let size = CGSize(width: 700, height: 700) // cell.b.width
        
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { (image, info) in
            
            if image != nil {
                cell.updateUI(img: image!)
            }
        }
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = self.arr[indexPath.row]
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true // or false
        
        let realsize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
        PHImageManager.default().requestImage(for: asset, targetSize: realsize , contentMode: .aspectFit, options: options) { (image, info) in
            
            if image != nil {
                self.globalI = image
                // cell.updateUI(img: image!)
                print("I have selected image fo size \(realsize.width) x \(realsize.height)")
                
                let run = self.runs[self.e]
                let time = Time(seconds: run.duration)
                let write = time.cleverTime
                var i = UIImage()
                
                if self.switcher.isOn == false {
                    self.grad = nil
                    self.light = nil
                } else {
                    self.grad = "#1abc9c"
                    self.light = "#2ecc71"
                }
                
                
                let vm = RunVM(run: run)
                
                i = self.g.genImage(image: image!, distance: run.distance, time: write, efpace: vm.sharePace, g1: self.grad, g2: self.light)
                self.imgview.image = i
                self.globalI = image! // not i !!!!
                self.imgview.image = i
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavbar()
        defaultGen()
        setForFirst()
    }
    
    
    func setNavbar(){
        navBar.topItem?.title = "Share"
    }
    
    func setForFirst(){
        switcher.setForFirst()
    }
    
    func defaultGen(){
        
        let options = PHFetchOptions()
        let all = PHAsset.fetchAssets(with: .image, options: options)
        
        for i in 0..<all.count {
            arr.append(all[i])
        }
        
        arr = arr.reversed() // :)
        
        
        if arr.count > 0 {
            let asset = arr[0]
            
            let options = PHImageRequestOptions()
            options.deliveryMode = .highQualityFormat
            options.isSynchronous = true // or false
            
            let realsize = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
            PHImageManager.default().requestImage(for: asset, targetSize: realsize , contentMode: .aspectFit, options: options) { (image, info) in
                
                if image != nil {
                    
                    let run = self.runs[self.e]
                    
                    let time = Time(seconds: run.duration)
                    let write = time.cleverTime
                    
                    let vm = RunVM(run: run)
                    var i = UIImage()
                    
                    i = self.g.genImage(image: image!, distance: run.distance, time: write, efpace: vm.sharePace, g1: self.grad, g2: self.light)
                    
                    self.gpace = vm.sharePace
                    self.imgview.image = i
                    self.globalI = image! // not i !!!!
                    self.gdist = run.distance
                    self.gtime = write
                }
            }
        }
        
    }
    
    
    
    @objc func make(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*-------2------------------------------------------------- SHARE ------------------------------------------------------*/
    
    @objc func share(sender: UIButton!){
        let w = imgview.image
        let share = UIActivityViewController(activityItems: [w!], applicationActivities: nil)
        present(share, animated: true, completion: nil)
    }
}


extension ShareViewController {
    
    func addUI(){
        [v, navBar, imgview, photosView, photoLabel, switcher, infol, ppicker/*, ppicker*/].forEach {view.addSubview($0)}
    }
    
    func constrainUI(){
        ppicker.pin(a: .top, b: .right, ac: 10, bc: 52, w: 30, h: 30, to: nil)
        switcher.pin(a: .top, b: .center, ac: 291, bc: 0, w: 60, h: 20, to: nil)
        infol.pinTo(switcher, position: .bottom, h: 30, margin: 10)
        photoLabel.pin(a: .top, b: .left, ac: 340, bc: 10, w: 130, h: 30, to: nil)
        photosView.bottomPin(top: 380, safe: false)
        imgview.pin(a: .top, b: .center, ac: 155, bc: 0, w: 300, h: 200, to: nil)
        v.ignorePin(a: .top, dist: 0, w: view.bounds.width, h: 50)
        navBar.pin(a: .top, b: .middle, ac: 0, bc: 0, w: view.bounds.width, h: 20, to: nil)
    }
}



extension ShareViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let s = info[.originalImage] as? UIImage
        
        if s != nil {
            print("WAS SET !!!!")
            let i = g.genImage(image: s!, distance: gdist, time: gtime, efpace: gpace, g1: self.grad, g2: self.light)
            imgview.image = i
            self.globalI = i
            
            // print("JUSTGOT \(self.grad)")
            UIImageWriteToSavedPhotosAlbum(s!, nil, nil, nil)
        }
        
        //viewWillAppear(true) // :D
        photosView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
}
