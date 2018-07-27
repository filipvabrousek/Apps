
import Foundation
import Photos

class Fetch {
    let asset: PHAsset
    let size: CGSize
    init(asset: PHAsset, size: CGSize){
        self.asset = asset
        self.size = size
    }
    
    func fetch() -> UIImage {
        var res: UIImage? = UIImage()
        PHImageManager.default().requestImage(for: self.asset, targetSize: self.size, contentMode: .aspectFit, options: nil) { (result, info) in
            if result != nil {
                res = result!
            }
        }
        return res!
    }
}



class ShowButton: UIButton{
   
    override func awakeFromNib() {
        self.setTitle("X", for: []) 
        self.setTitleColor(UIColor.green, for: [])
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
   
}







@IBDesignable
class VibranceSlider: UISlider{
    @IBInspectable var thickness: CGFloat = 6 {
        didSet{
            setup()
        }
    }
    
    @IBInspectable var thumb: UIImage? {
        didSet {
            setup()
        }
    }
    
    func setup(){
        let min = UIColor.blue
        let center = UIColor.red
        let max = UIColor.clear
        
        let mingrad = self.gradient(size: self.trackRect(forBounds: self.bounds).size, colorSet: [min.cgColor, center.cgColor])
        self.setMinimumTrackImage(mingrad, for: []) // .normal
        
        let maxgrad = self.gradient(size: self.trackRect(forBounds: self.bounds).size,colorSet: [max.cgColor, max.cgColor])
        self.setMaximumTrackImage(maxgrad, for: [])
        
        self.setThumbImage(thumb, for: .normal)
    }
    
    
    
    func gradient(size: CGSize, colorSet:[CGColor]) -> UIImage {
        let gl = CAGradientLayer()
        gl.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gl.cornerRadius = gl.frame.height / 2
        gl.masksToBounds = false
        gl.colors = colorSet
        gl.startPoint = CGPoint(x: 0, y: 0.5)
        gl.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, gl.isOpaque, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        gl.render(in: ctx!)
        
        let insects = UIEdgeInsets(top: 0, left: size.height, bottom: 0, right: size.height)
        let image = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: insects)
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: thickness)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}




class FSlider: UISlider {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.minimumValue = 0.0
        self.maximumValue = 1.0
      //  self.value = 1.0 
        self.tintColor = UIColor.white
        self.thumbTintColor = UIColor.white
        self.isContinuous = true
        self.backgroundColor = UIColor.black
    } 
}






import UIKit

class TabCell: UICollectionViewCell{
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        imgView.contentMode = .scaleToFill
        addSubview(imgView)
    }
    
    func constrain(){
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}






import UIKit

class FilterCell: UICollectionViewCell {
    
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        imgView.contentMode = .scaleToFill
        addSubview(imgView)
    }
    
    func constrain(){
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}






import UIKit

class PhotoCell: UICollectionViewCell {
 
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        imgView.contentMode = .scaleToFill
        addSubview(imgView)
    }
    
    func constrain(){
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imgView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}






import UIKit

class CropCell: UICollectionViewCell{
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(label)
    }
    
    func constrain(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
   
    
}







import UIKit
import Photos

class ImportViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate { // PICKER delegate
    
    // variables
    var collectionView:UICollectionView!
    var assets: PHAssetCollection = PHAssetCollection()
    let picker = UIImagePickerController()
    var arr = [PHAsset]() // fill in
    var pass:UIImage? = nil // image that will be passed to "Edit VC"
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = PHFetchOptions()
        let all = PHAsset.fetchAssets(with: .image, options: options)
        
        for el in 0..<all.count{
            let a = all[el]
            arr.append(a)
        }
        arr.reverse()
        addCV()
        addShot()
    }
    
    
    func addCV(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 110, height: 110)
        layout.minimumInteritemSpacing = 0 // remove spacing
        layout.minimumLineSpacing = 10
        
        let rect = CGRect(x: 0, y: 60, width: self.view.bounds.width, height: 480)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PCell")
        collectionView.backgroundColor = UIColor.clear
        
        view.addSubview(collectionView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    
    
    /*---------------2--------------------------------------------COLLECTIONVIEW---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PCell", for: indexPath) as! PhotoCell
        let asset = self.arr[indexPath.row]
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        
        let size = CGSize(width: cell.bounds.width, height:cell.bounds.height)
        var res = UIImage()
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { (result, info) in
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
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        
        
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) { (result, info) in
            if result != nil {
                res = result!
            }
        }
        
        // self.pass = res
        
        let evc = EditViewController()
        evc.img = res
        navigationController?.pushViewController(evc, animated: false)
    }
    
    
    
    /*---------------4--------------------------------------------SHOT IMAGE---------------------------------------------------------
     */
    
    
    
    
    func addShot(){
        let save = UIButton()
        save.setTitle("TAKE PHOTO", for: [])
        save.frame = CGRect(x: 90, y: 600, width: 200, height: 20)
        save.setTitleColor(UIColor.white, for: [])
        save.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        save.addTarget(self, action: #selector(self.shot(sender:)), for: .touchUpInside)
        view.addSubview(save)
    }
    
    
    @objc func shot(sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let picked = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker.dismiss(animated: false, completion: nil)
        let evc = EditViewController()
        evc.img = picked
        navigationController?.pushViewController(evc, animated: true)
    }
    
    
    
    
}


}




import UIKit
import CoreImage

class EditViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    var toolView: UICollectionView!
    var filterView:UICollectionView! // NO var vc = UICollectionView() -> would be ERROR  !!!!
    
    // variables
    var img:UIImage? = nil
    var imgView = UIImageView()
    var selected = [String]() // selected filters
    var active = 1 // first set of filters UI is active
    var rvalue:Double = 0.0
    var gvalue:Double = 0.0
    var bvalue:Double = 0.0
    var vvalue:Double = 0.0 // vibrance
    
    // Arrays
    var tools = ["filters", "color", "crop"] // + curves
    var filters = ["CIPhotoEffectNoir", "CISepiaTone", "CICrystallize", "CICMYKHalftone", "CIColorInvert"]
    var bfilters = ["vibrance", "color", "exposure"]
    
    
    // Working with views
    var sview = UIStackView()
    var VSlider = UISlider() // vibrance
    var CSlider = FSlider() // color
    var ESlider = FSlider() // exposure
    var RSlider = FSlider() // contrast
    var modify = ""
    var setting = "none"
    var hider = UIView()
    let show = UIButton()
    
    
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidAppear(_ animated: Bool) {
        selected.removeAll() // clear selected filters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VSlider.isHidden = true
        CSlider.isHidden = true
        ESlider.isHidden = true
        RSlider.isHidden = true
        sview.isHidden = true
        
        addVSlider()
        addESlider()
        addCSlider()
        addRSlider()
        addStackView()
        addImage()
        addSave()
        addShower()
        addToolView()
        addFilterView()
    }
    
    
    
    
    func addFilterView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 70, height: 70)
        layout.scrollDirection = .horizontal
        
        let rect = CGRect(x: 0, y: 510, width: self.view.bounds.width, height: 90)
        filterView = UICollectionView(frame: rect, collectionViewLayout: layout)
        filterView.delegate = self
        filterView.dataSource = self
        filterView.register(FilterCell.self, forCellWithReuseIdentifier: "FCell")
        filterView.backgroundColor = UIColor.black
        
        view.addSubview(filterView)
    }
    
    
    
    func addToolView(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 40, height: 40) // 70
        layout.scrollDirection = .horizontal
        
        let rect = CGRect(x: 0, y: 580, width: self.view.bounds.width, height: 90)
        toolView = UICollectionView(frame: rect, collectionViewLayout: layout)
        toolView.delegate = self
        toolView.dataSource = self
        toolView.register(TabCell.self, forCellWithReuseIdentifier: "TCell")
        toolView.backgroundColor = UIColor.black
        
        view.addSubview(toolView)
    }
    
    
    func addImage(){
        imgView.image = img!
        imgView.contentMode = .scaleAspectFit
        imgView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 290)
        view.addSubview(imgView)
    }
    
    
    
    func addSave(){
        let save = UIButton()
        save.setTitle("Save", for: [])
        save.frame = CGRect(x: 0, y: 80, width: 60, height: 20)
        save.setTitleColor(UIColor.green, for: [])
        save.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        save.addTarget(self, action: #selector(self.save(sender:)), for: .touchUpInside)
        view.addSubview(save)
    }
    
    
    
    
    
    /*---------------3--------------------------------------------NUMBEROFROWS---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var ret = 0
        if collectionView == toolView {
            ret = tools.count
        } else {
            if (active == 1){
                ret = filters.count
            } else if (active == 2) {
                ret = bfilters.count
            } else if active == 3 {
                ret = 0
            }
        }
        
        return ret
        
    }
    
    
    /*---------------4--------------------------------------------CELLFORITEM---------------------------------------------------------
     */
    
    let icons = ["filter.png", "colors.png", "crop.png"]
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == toolView{
            let cell = toolView.dequeueReusableCell(withReuseIdentifier: "TCell", for: indexPath) as! TabCell
            cell.imgView.image = UIImage(named: icons[indexPath.row])
            cell.backgroundColor = UIColor.black
            return cell
            
        } else {
            
            let cell = filterView.dequeueReusableCell(withReuseIdentifier: "FCell", for: indexPath) as! FilterCell
            cell.backgroundColor = UIColor.orange
            if (active == 1){
                //  let res = apply(filter: filters[indexPath.row], value: 1.0) // HERE IS PROBLEM
                let res = aplCell(filter: filters[indexPath.row], value: 1.0)
                cell.imgView.image = res
            } else if active == 2 {
                cell.imgView.image = img!
            } else if active == 3 {
                print("IOBOBO")
                
            }
            
            return cell
        }
        
        
    }
    
    
    
    /*---------------5--------------------------------------------DIDSELECTITEMAT---------------------------------------------------------*/
    func oneTabMode(){ // tab 1 black bottom bar is selected, show just filterView
        sview.isHidden = true
        CSlider.isHidden = true
        VSlider.isHidden = true
        filterView.isHidden = false
    }
    
    func twoTabMode(){ // tab 2 is selected, show just filter view, but its content will be different
        sview.isHidden = true
        CSlider.isHidden = true
        VSlider.isHidden = true // false ????????
        filterView.isHidden = false
    }
    
    func threeTabMode(){ // tab 3 is selected, perform segue to crop view controller
        filterView.isHidden = true
        sview.isHidden = true
        CSlider.isHidden = true
        // self.performSegue(withIdentifier: "toCrop", sender: self)
        let cvc = CropViewController()
        cvc.img = imgView.image!
        navigationController?.pushViewController(cvc, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == toolView {
            active = indexPath.row + 1
            filterView.reloadData() // reloads cells to new data
            
            if active == 1 {
                oneTabMode()
            }
            
            if active == 2 {
                twoTabMode()
            }
            
            if active == 3 {
                threeTabMode()
            }
            
            
        } else {
            if (active == 1){
                let filter = filters[indexPath.row]
                selected.append(filter)
                
                let inp = Process(image: imgView.image!)
                let res = inp.apply(filter: filter)
                imgView.image = res
                filterView.reloadData()
                
                
            } else if (active == 2) { // only case when we decide what will be hidden (vibrance and color view)
                filterView.reloadData()
                
                if indexPath.row == 0 {
                    vibranceMode()
                } else if indexPath.row == 1 {
                    colorMode()
                } else if indexPath.row == 2 {
                    exposureMode()
                }
                
            } else if active == 3 {
                print("Entered crop mode")
            }
            
        }
    }
    
    func vibranceMode(){
        VSlider.isHidden = false // VibranceSlider selected
        sview.isHidden = true
        CSlider.isHidden = true
        hideViews()
        show.isHidden = false
    }
    
    func colorMode(){
        sview.isHidden = false // Color mode: show UISlider, VSlider, hide btn and hide both "colectionviews"
        CSlider.isHidden = false
        VSlider.isHidden = true
        ESlider.isHidden = true
        RSlider.isHidden = true
        hideViews()
        show.isHidden = false
        
    }
    
    func exposureMode(){
        sview.isHidden = true // Color mode: show UISlider, VSlider, hide btn and hide both "colectionviews"
        CSlider.isHidden = true
        ESlider.isHidden = false
        RSlider.isHidden = false
        VSlider.isHidden = true
        hideViews()
        show.isHidden = false
    }
    
    
    func hideViews(){
        toolView.isHidden = true
        filterView.isHidden = true
    }
    
    func showViews(){
        toolView.isHidden = false
        filterView.isHidden = false
    }
    
    
    
    func addShower(){
        show.setTitle("X", for: [])
        show.frame = CGRect(x: 30, y: 520, width: 60, height: 20)
        show.setTitleColor(UIColor.white, for: [])
        show.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        show.addTarget(self, action: #selector(self.bshow(sender:)), for: .touchUpInside)
        show.isHidden = true
        self.view.addSubview(show)
        /* UIButton subclass not working
         show.addTarget(self, action: #selector(self.bshow(sender:)), for: .touchUpInside)
         show.isHidden = false
         show.frame = CGRect(x: 30, y: 520, width: 60, height: 20)
         self.view.addSubview(show)*/
    }
    
    @objc func bshow(sender:UIButton!){ // show UI after hiding it to make space for CSlider, VSlider and ESlider
        
        toolView.isHidden = false
        filterView.isHidden = false
        CSlider.isHidden = true
        VSlider.isHidden = true
        ESlider.isHidden = true
        RSlider.isHidden = true
        sview.isHidden = true
        sender.isHidden = true
    }
    
    
 
    /*---------------2--------------------------------------------UI---------------------------------------------------------
     */
    func addStackView(){
        
        // -------------------------------------------- buttons
        let red = UIButton()
        red.setTitle("●", for: [])
        red.setTitleColor(UIColor.red, for: [])
        red.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        red.addTarget(self, action: #selector(self.test(sender:)), for: .touchUpInside)
        
        let green = UIButton()
        green.setTitle("●", for: [])
        green.setTitleColor(UIColor.green, for: [])
        green.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        green.addTarget(self, action: #selector(self.test(sender:)), for: .touchUpInside)
        
        let blue = UIButton()
        blue.setTitle("●", for: [])
        blue.setTitleColor(UIColor.blue, for: [])
        blue.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        blue.addTarget(self, action: #selector(self.test(sender:)), for: .touchUpInside)
        
        
        // -------------------------------------------- stack view
        sview.isHidden = true
        sview.frame = CGRect(x: 0, y: 580, width: 90, height: 20)
        sview.center.x = self.view.center.x
        print("sview.frame.width: \(sview.frame.width)")
        print("Position: \(self.view.bounds.width / 2)")
        
        sview.axis = .horizontal
        sview.distribution = .equalSpacing
        sview.alignment = .center
        sview.addArrangedSubview(red)
        sview.addArrangedSubview(green)
        sview.addArrangedSubview(blue)
        view.addSubview(sview)
        
        
        
    }
    
    func addCSlider(){
        // -------------------------------------------- color slider
        CSlider.frame = CGRect(x: 30, y: 630, width: self.view.frame.width - 30, height: 20) // 480
        CSlider.tintColor = UIColor.red
        CSlider.thumbTintColor = UIColor.orange
        CSlider.addTarget(self, action: #selector(cslided(sender:)), for: .valueChanged)
        view.addSubview(CSlider) // Use FSlider subclass
    }
    
    @objc func test(sender: UIButton!){ // change slider apperance and change "modify" depending on which color is selected
        
        if sender.currentTitleColor == UIColor.red {
            modify = "red"
            CSlider.tintColor = UIColor.red
            CSlider.thumbTintColor = UIColor.red
        } else if sender.currentTitleColor == UIColor.green {
            modify = "green"
            CSlider.tintColor = UIColor.green
            CSlider.thumbTintColor = UIColor.green
        } else {
            modify = "blue"
            CSlider.tintColor = UIColor.blue
            CSlider.thumbTintColor = UIColor.blue
        }
    }
    
    
    @objc func cslided(sender: UISlider){ // color image depending on which color is set = call "color()" below
        if modify == "red"{
            rvalue = Double(sender.value)
        }
        
        if modify == "green"{
            gvalue = Double(sender.value)
        }
        
        if modify == "blue"{
            bvalue = Double(sender.value)
        }
        
        color(rvalue: rvalue, gvalue: gvalue, bvalue: bvalue)
    }
    
    
    func color(rvalue:Double, gvalue: Double, bvalue:Double){ // color image
        
        let image = Image(image: imgView.image!)
        
        let red = rvalue * 255.0
        let blue = bvalue * 255.0
        let green = gvalue * 255.0
        
        print(red, green, blue)
        let f = Color(r: red, g: green, b: blue)
        let res = f.apply(input: image)
        imgView.image = res.toUIImage()
    }
    
    
    
    func addVSlider(){ // add vibrance slider
        
        VSlider = VibranceSlider()
        VSlider.isHidden = true
        VSlider.frame = CGRect(x: 30, y: 630, width: view.frame.width - 30, height: 20)
        VSlider.minimumValue = 0.0
        VSlider.maximumValue = 1.0
        VSlider.value = 0.0
        VSlider.tintColor = UIColor.orange
        VSlider.thumbTintColor = UIColor.blue
        VSlider.isContinuous = true
        VSlider.addTarget(self, action: #selector(slideo(sender:)), for: .valueChanged)
        view.addSubview(VSlider)
        VSlider.backgroundColor = UIColor.black
    }
    
    
    @objc func slideo(sender: UISlider){ // change vibrance, depending on VibranceSlider value
        vvalue = Double(sender.value)
        saturation(val: Float(vvalue))
    }
    
    
    
    
    func saturation(val:Float){ // brightness fix this :D
        let inp = Process(image: imgView.image!)
        imgView.image = inp.saturated(to: val)
    }
    
    
    
    func addESlider(){
        ESlider.frame = CGRect(x: 30, y: 550, width: self.view.frame.width - 30, height: 20) // 480
        ESlider.addTarget(self, action: #selector(eslided(sender:)), for: .valueChanged)
        ESlider.minimumValue = 0.0
        ESlider.maximumValue = 2.0
        ESlider.value = 1.0
        view.addSubview(ESlider) // Use FSlider subclass
    }
    
    
    func addRSlider(){
        RSlider.frame = CGRect(x: 30, y: 610, width: self.view.frame.width, height: 20)
        RSlider.addTarget(self, action: #selector(rslided(sender:)), for: .valueChanged)
        RSlider.minimumValue = 0.0
        RSlider.maximumValue = 4.0
        RSlider.value = 1.0
        view.addSubview(RSlider)
    }
    
    @objc func eslided(sender: UISlider){ // color image depending on which color is set = call "color()" below
        let val = sender.value
        saturate(val: val)
    }
    
    @objc func rslided(sender: UISlider){ // color image depending on which color is set = call "color()" below
        let val = sender.value
        contrast(val: val)
    }
    
    
    func saturate(val: Float){
        let inp = Process(image: imgView.image!)
        imgView.image = inp.saturated(to: val)
    }
    
    
    func contrast(val:Float){ // contrast fix this :D
        let inp = Process(image: imgView.image!)
        imgView.image = inp.contrasted(to: val)
    }
    
    
    func aplCell(filter: String, value:Float) -> UIImage {
        let toMake = img!
        let inp = Process(image: toMake)
        let res = inp.apply(filter: filter)
        return res
    }
    
    func apply(filter: String, value:Float) -> UIImage { // used in previews
        let toMake = imgView.image
        let inp = Process(image: toMake!)
        let res = inp.apply(filter: filter)
        return res
    }
    
    
    
    /*---------------7--------------------------------------------SAVE, PREPARE---------------------------------------------------------
     */
    
    @objc func save(sender: UIButton!) {
        if let data = UIImagePNGRepresentation(imgView.image!){
            let compressed = UIImage(data: data)
            UIImageWriteToSavedPhotosAlbum(compressed!, nil, nil, nil)
            print("Saved")
        } else {
            print("Saving failed")
        }





import UIKit

class CropViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
   

    var imgView = UIImageView()
    var cropView: UICollectionView!
    
    // variables - 4
    var rotateSlider = FSlider()
    var img: UIImage?
    let overlay = UIView()
    var last = CGPoint.zero // last point
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        //imgView.image = img!
        addSlider()
        addImage()
        addCrop() // button
        addShare()
        addCropView()
        initOverlay(x: 0, y: 0)
    }
    
    
    
    
    /*---------------2--------------------------------------------COLLECTIONVIEW---------------------------------------------------------
     */
    let aside = ["1", "1", "3"]  // width
    let bside = ["1", "1", "2"]  // height
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aside.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CropCell
        cell.backgroundColor = UIColor.white
        if indexPath.row != 2{
            cell.label.text = "\(aside[indexPath.row]):\(bside[indexPath.row])"
        } else {
            cell.label.text = "FB"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let b = UIView()
            b.frame = CGRect(x: 0, y: 0, width: (img?.cgImage?.height)!, height: (img?.cgImage?.height)!)
            imgView.image = imgView.image?.crop(to: b.frame)
        } else if indexPath.row == 1 {
            imgView.image = imgView.image?.cropInRatio(a: 1, b: 1)
        } else if indexPath.row == 2{
            imgView.image = imgView.image?.cropInRatio(a: 3, b: 2)
        }
        
    }
    
    
    /*---------------3--------------------------------------------ADD UI---------------------------------------------------------
     */
    func addCropView(){
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 70, height: 70)
            layout.scrollDirection = .horizontal
            
            let rect = CGRect(x: 0, y: 580, width: self.view.bounds.width, height: 90)
            cropView = UICollectionView(frame: rect, collectionViewLayout: layout)
            cropView.delegate = self
            cropView.dataSource = self
            cropView.register(CropCell.self, forCellWithReuseIdentifier: "CCell")
            cropView.backgroundColor = UIColor.black
            view.addSubview(cropView)
    }
    
    
    func addImage(){
        imgView.image = img!
        imgView.contentMode = .scaleAspectFit
        imgView.frame = CGRect(x: 0, y: 70, width: view.frame.width, height: 290)
        view.addSubview(imgView)
    }
    
    func addCrop(){
        let crop = UIButton()
        crop.setTitle("Crop", for: [])
        crop.frame = CGRect(x: 30, y: 550, width: 60, height: 20)
        crop.setTitleColor(UIColor.green, for: [])
        crop.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        crop.addTarget(self, action: #selector(self.perform(sender:)), for: .touchUpInside)
        view.addSubview(crop)
    }
    
    
    @objc func perform(sender:UIButton!){
       let res = imgView.image?.crop(to: overlay.frame)
       imgView.image = res
    }
    
    func addSlider(){
        rotateSlider.frame = CGRect(x: 30, y: 520, width: self.view.frame.width - 30, height: 20)
        rotateSlider.thumbTintColor = UIColor.orange
        rotateSlider.addTarget(self, action: #selector(rslided(sender:)), for: .valueChanged)
        view.addSubview(rotateSlider) // Use FSlider subclass
    }
    
    @objc func rslided(sender: UISlider){
        let val = CGFloat(rotateSlider.value)
        imgView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3.0 * val)
    }
    
    
    func addShare(){
        let crop = UIButton()
        crop.setTitle("Share", for: [])
        crop.frame = CGRect(x: 230, y: 550, width: 60, height: 20)
        crop.setTitleColor(UIColor.green, for: [])
        crop.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        crop.addTarget(self, action: #selector(self.shareg(sender:)), for: .touchUpInside)
        view.addSubview(crop)
    }
    
    
    @objc func shareg(sender:UIButton!){
        let shv = ShareViewController()
        shv.img = imgView.image!
        navigationController?.pushViewController(shv, animated: false)
    }
    
  
    
    /*---------------4--------------------------------------------OVERLAY---------------------------------------------------------
     */
    func initOverlay(x: CGFloat, y:CGFloat){
        overlay.frame = CGRect(x: 70, y: 70, width: 150, height: 150)
        overlay.layer.borderColor = UIColor.orange.cgColor
        overlay.layer.borderWidth = 2.0
        overlay.isHidden = false // true?
        view.addSubview(overlay)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            last = touch.location(in: imgView) // view
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let curr = touch.location(in: imgView) // self.view
            redraw(from: last, to: curr)
        }
    }
    
    func redraw(from: CGPoint, to: CGPoint){
        overlay.isHidden = false
        
        let rect = CGRect(x: min(from.x, to.x),
                          y: min(from.y, to.y),
                          width: fabs(from.x - to.x),
                          height: fabs(from.y - to.y))
        overlay.frame = rect
        print("\(rect.width) x \(rect.height)")
    }
}


/*---------------5--------------------------------------------CROPPING EXTENSION---------------------------------------------------------
 */
extension UIImage {
    func crop(to: CGRect) -> UIImage {
        func rad(_ degree:Double) -> CGFloat{
            return CGFloat(degree / 180.0 * Double.pi)
        }
        
        var transform: CGAffineTransform
        switch imageOrientation {
        case .left:
            transform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
        case .right:
            transform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
            
        case .down:
            transform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
        default:
            transform = .identity
        }
        transform = transform.scaledBy(x: self.scale, y: self.scale)
        
        let ref = self.cgImage?.cropping(to: to.applying(transform))
        let res = UIImage(cgImage: ref!, scale: self.scale, orientation: self.imageOrientation)
        return res
    }
    
    
    
    func cropInRatio(a: Double, b:Double) -> UIImage {
        
        func rad(_ degree:Double) -> CGFloat{
            return CGFloat(degree / 180.0 * Double.pi)
        }
        
        var transform: CGAffineTransform
        switch imageOrientation {
        case .left:
            transform = CGAffineTransform(rotationAngle: rad(90)).translatedBy(x: 0, y: -self.size.height)
        case .right:
            transform = CGAffineTransform(rotationAngle: rad(-90)).translatedBy(x: -self.size.width, y: 0)
            
        case .down:
            transform = CGAffineTransform(rotationAngle: rad(-180)).translatedBy(x: -self.size.width, y: -self.size.height)
        default:
            transform = .identity
        }
        transform = transform.scaledBy(x: self.scale, y: self.scale)
        
        
        let sum = a + b // 3(width):2(height) -> 5
        var neww = 0.0
        var newh = 0.0
        if a > b{ // width > height
            neww = Double((self.cgImage?.width)!) / sum * a
            newh = Double((self.cgImage?.width)!) / sum * b
        } else {
            neww = Double((self.cgImage?.width)!) / sum * a
            newh = Double((self.cgImage?.width)!) / sum * b
        }
      
        
        let to = CGRect(x: 0, y: 0, width: neww, height: newh)
        let ref = self.cgImage?.cropping(to: to.applying(transform))
        let res = UIImage(cgImage: ref!, scale: self.scale, orientation: self.imageOrientation)
        return res
    }
}








import UIKit

class ShareViewController: UIViewController {
    
    var img: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShare()
    }
    
    
    func addShare(){
        let btn = UIButton()
        btn.frame = CGRect(x: 100, y: 120, width: 100, height: 20)
        btn.tintColor = UIColor.orange
        btn.setTitle("Share", for: [])
        btn.addTarget(self, action: #selector(share(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func share(sender: UIButton!) {
        let act = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        present(act, animated: true, completion: nil)
    }
    
}



import UIKit


protocol Filter {
    func apply(input: Image) -> Image
}

class Color: Filter {
    var r: Double
    var g: Double
    var b: Double
    
    init(r:Double, g:Double, b:Double){
        self.r = r
        self.g = g
        self.b = b
    }
    
    func apply(input: Image) -> Image {
        return input.transform(cb: { (px: Pixel) -> Pixel in
            var p = px
            p.red = UInt8(self.r) // p.red = UInt8(Double(p.red) * self.r)
            p.green = UInt8(self.g) // must be less than 255
            p.blue = UInt8(self.b)
            return p
        })
    }
}



class Vibrance: Filter {
    var amount: Double
    
    init(amount: Double){
        self.amount = amount
    }
    
    func apply(input: Image) -> Image {
        return input.transform(cb: { (px: Pixel) -> Pixel in
            var p = px
            p.red = UInt8(amount)
            p.green = UInt8(amount)
            p.blue = UInt8(amount)
            return p
        })
    }
}





class Process {
    var image: UIImage = UIImage()
    
    init(image: UIImage){
        self.image = image
    }
    
    
    func apply(filter: String) -> UIImage {
       
        let img = image.cgImage
        let ci = CIImage(cgImage: img!) //CIImage(cgImage: imgView.image!.cgImage!) // CRASH
        let filter = CIFilter(name: filter)
        filter?.setValue(ci, forKey: "inputImage") // kCIInputSharpnessKey // kCIInputImageKey
        let output = filter?.value(forKey: "outputImage") as! CIImage
     
        let ctx = CIContext() // create output to be able to crop UIImage creted from CGImage is not backed by cgImage
        let ft = ctx.createCGImage(output, from: output.extent)
        let ret = UIImage(cgImage: ft!, scale: image.scale, orientation: image.imageOrientation)
        return ret
    }
    
    
    
    func saturated(to:Float) -> UIImage { // fix
        print("to \(to)")
        let img = image.cgImage
        let ci = CIImage(cgImage: img!)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(ci, forKey: "inputImage")
      //  filter?.setValue(to + 1.0, forKey: "inputSaturation")
        filter?.setValue(to, forKey: "inputSaturation")
        let res = filter?.value(forKey: "outputImage") as! CIImage
        let cgi = CIContext(options: nil).createCGImage(res, from: res.extent)
        let ret = UIImage(cgImage: cgi!, scale: image.scale, orientation: image.imageOrientation)
        return ret
    }
    
 
    func contrasted(to:Float) -> UIImage {
        let inp = CIImage(image: image)!
        let param = [
            "inputContrast": NSNumber(value: to)  // 1 is default value to / 10 * 10
        ]
        let out = inp.applyingFilter("CIColorControls", parameters: param)
        let ctx = CIContext(options: nil)
        let cgi = ctx.createCGImage(out, from: out.extent)
        let ret = UIImage(cgImage: cgi!, scale: image.scale, orientation: image.imageOrientation)
        return ret
    }
    
}





import UIKit
import CoreGraphics


class Image {
    let pixels: UnsafeMutableBufferPointer<Pixel> // allocate memory for the image data
    let width: Int
    let height: Int
    let space = CGColorSpaceCreateDeviceRGB()
    let bitmap: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue // what kind of pixel we want to decode (32 bit pixels)
    let bits = Int(8) // 32 bit representation of each pixel (32 / colours (r, g, b, alpha) = 8)
    let rowBits: Int
    
    /*------------------------------------------------FIRST INIT-------------------------------------------------------------*/
    init(width: Int, height: Int){ // use at the bottom
        self.width = width
        self.height = height
        rowBits = 4 * width // bits per row
        let rawData = UnsafeMutablePointer<Pixel>.allocate(capacity: (width * height))
        // allocate buffer for all the pixels (temporary storage of data between proccesses)
        pixels = UnsafeMutableBufferPointer<Pixel>(start: rawData, count: width * height)
    }
 
    
    /*------------------------------------------------2ND INIT-------------------------------------------------------------*/
    init(image: UIImage){
        height = Int(image.size.height)
        width = Int(image.size.width)
        rowBits = 4 * width // bits per row
        
        // create and draw image from data
        let rawData = UnsafeMutablePointer<Pixel>.allocate(capacity: (width * height))
        let zero = CGPoint.zero // X[0,0]
        let rect = CGRect(origin: zero, size: image.size) // create rect for the image
        let ctx = CGContext(data: rawData, width: width, height: height, bitsPerComponent: bits, bytesPerRow: rowBits, space: space, bitmapInfo: bitmap)
        ctx?.draw(image.cgImage!, in: rect) // draw new image from data
        pixels = UnsafeMutableBufferPointer<Pixel>(start: rawData, count: width * height)
        // pixels are used at getPixel, set Pixel and UIImage
    }
    
    
    /*----------------------------------------------TO UIIMAGE-----------------------------------------------------------*/
    func toUIImage() -> UIImage { // convert image to UIImage
    let ctx = CGContext(data: pixels.baseAddress, width: width, height: height, bitsPerComponent: bits, bytesPerRow: rowBits, space: space, bitmapInfo: bitmap) // different constructor ???
        return UIImage(cgImage: ctx!.makeImage()!)
    }
    
    /*----------------------------------------------GET AND SET PIXELS-----------------------------------------------------------*/
    func getPixel(x:Int, y:Int) -> Pixel {
        return pixels[x+y*width]
    }
    
    func setPixel(value: Pixel, x:Int, y:Int) { // change values in pixels array
        pixels[x+y*width] = value
    }
    
    
    /*----------------------------------------------TRANSFORM-----------------------------------------------------------*/
    func transform(cb: (Pixel) -> Pixel) -> Image{
        let new = Image(width: self.width, height: self.height)
        
        for x in 0 ..< width{
            for y in 0 ..< height{
                let p = getPixel(x: x, y: y)
                let s = cb(p) // apply callback for each pixel
                new.setPixel(value: s, x: x, y: y) // fill-in pixels array with new pixels
            }
        }
        
        return new
    }
    
    

}








import UIKit
import CoreGraphics


struct Pixel {
    
    public var raw: UInt32
    
    public init(rawVal: UInt32){
        raw = rawVal
    }
    
    public init(r:UInt8, g:UInt8, b:UInt8) { // we limit usage of colours to 255
        raw = 0xFF000000 | UInt32(r) | UInt32(g) << 8 | UInt32(b) << 16
    }
    
    public init(uiColor: UIColor){
        var r: CGFloat = 0.0
        var g:CGFloat = 0.0
        var b: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &alpha)
        self.init(r: UInt8(r * 255), g: UInt8(r * 255), b: UInt8(r * 255))
    }
    
    
    
    public var red: UInt8 {
        get { return UInt8(raw & 0xFF)}
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var green: UInt8{
        get { return UInt8(raw & 0xFF)}
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var blue: UInt8{
        get {return UInt8(raw & 0xFF)}
        set {raw = UInt32(newValue) | (raw & 0xFFFFFF00)}
    }
    
    public var alpha:UInt8 {
        get {return UInt8((raw & 0xFF000000) >> 24)}
        set {raw = (UInt32(newValue) << 24) | (raw & 0x00FFFFFF)}
    }
    
    public var averageIntensity: UInt8{
        get {return UInt8 ((UInt32(red) + UInt32(green) + UInt32(blue)) / 3)}
    }
    
    public func toUIColor() -> UIColor {
        return UIColor(
            red: CGFloat(self.red) / CGFloat(255),
            green: CGFloat(self.green) / CGFloat(255),
            blue: CGFloat(self.blue) / CGFloat(255),
            alpha: CGFloat(self.alpha) / CGFloat(255))
    }
}




struct HSLPixel {
    var h:CGFloat = 0.0
    var s:CGFloat = 0.0
    var l:CGFloat = 0.0
    var a:CGFloat = 0.0
}



    
    


