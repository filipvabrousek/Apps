import UIKit
import Photos

class ImportViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate { // PICKER delegate
    
    // outlets and variables
    @IBOutlet var collectionView: UICollectionView!
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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0 // remove spacing
        layout.minimumLineSpacing = 0
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
        
        self.pass = res
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let edit = segue.destination as! EditViewController
            edit.img = self.pass!
        }
    }
    
    /*---------------4--------------------------------------------SHOT IMAGE---------------------------------------------------------
     */
    
    @IBAction func shot(_ sender: Any) {
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
        self.pass = picked
        picker.dismiss(animated: false, completion: nil)
        self.performSegue(withIdentifier: "toEdit", sender: self)
    }
    
    
    
    
}







import UIKit
import CoreImage

class EditViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    // outlets - 2 => everything else is code :D
    @IBOutlet var toolView: UICollectionView!
    @IBOutlet var filterView: UICollectionView!
    
    
   // variables
    var img:UIImage? = nil
    var imgView = UIImageView()
    var selected = [String]() // selected filters
    var active = 1 // first set of filters UI is active
    var rvalue: Double = 0.0
    var gvalue:Double = 0.0
    var bvalue:Double = 0.0
    var vvalue:Double = 0.0 // vibrance
    
    // Arrays
    var tools = ["filters", "color", "crop"] // + curves
    var filters = ["CIPhotoEffectNoir", "CISepiaTone", "CICrystallize", "CICMYKHalftone", "CIColorInvert"]
    var bfilters = ["fake", "fake"]
    
    // Working with views
    var modify = ""
    var sview = UIStackView()
    var progSlider = UISlider()
    var CSlider = FSlider()
    var setting = "none"
    
    
    
    
    
    /*---------------1--------------------------------------------LIFECYCLE---------------------------------------------------------
     */
    override func viewDidAppear(_ animated: Bool) {
        selected.removeAll() // clear selected filters
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        toolView.delegate = self
        toolView.dataSource = self
        toolView.backgroundColor = UIColor.black
        filterView.delegate = self
        filterView.dataSource = self
        filterView.backgroundColor = UIColor.black
        progSlider.isHidden = true
        sview.isHidden = true
        CSlider.isHidden = true
        addSlider()
        addStackView()
        addImage()
        addSave()
    }
    
    func addImage(){
        imgView.image = img!
        imgView.contentMode = .scaleAspectFill
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
        sview.frame = CGRect(x: 0, y: 460, width: 90, height: 20)
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
        
        
        // -------------------------------------------- color slider
        CSlider.frame = CGRect(x: 30, y: 480, width: self.view.frame.width - 30, height: 20)
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
    
    

    func addSlider(){ // add vibrance slider
        
        progSlider = VibranceSlider()
        progSlider.isHidden = true
        progSlider.frame = CGRect(x: 30, y: 480, width: view.frame.width - 30, height: 20)
        progSlider.minimumValue = 0.0
        progSlider.maximumValue = 1.0
        progSlider.value = 0.0
        progSlider.tintColor = UIColor.orange
        progSlider.thumbTintColor = UIColor.blue
        progSlider.isContinuous = true
        progSlider.addTarget(self, action: #selector(slideo(sender:)), for: .valueChanged)
        view.addSubview(progSlider)
        progSlider.backgroundColor = UIColor.black
    }
    
    
    @objc func slideo(sender: UISlider){ // change vibrance, depending on VibranceSlider value
        vvalue = Double(sender.value)
        vibrance(value: vvalue)
    }
    
    
    func vibrance(value:Double){
        let image = Image(image: img!)
        let amount = value * 255.0 // vibrance slider
        let f = Vibrance(amount: amount)
        let res = f.apply(input: image)
        imgView.image = res.toUIImage()
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
            
            if (active == 1){
                let res = apply(filter: filters[indexPath.row], value: 1.0)
                cell.imgView.image = res
            } else if active == 2 {
                cell.imgView.image = img!
            } else if active == 3 {
                print("IOBOBO")
                
            }
            
            return cell
        }
        
        
    }
    
    
    
    /*---------------5--------------------------------------------DIDSELECTITEMAT---------------------------------------------------------
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == toolView {
            
            active = indexPath.row + 1
            filterView.reloadData() // reloads cells to new data
            let tool = tools[indexPath.row]
            print(" tool: \(tool), active: \(active)")
            
            if (active == 1){
                sview.isHidden = true
                CSlider.isHidden = true
                progSlider.isHidden = true
                filterView.isHidden = false
            }
            
            if (active == 2){
                sview.isHidden = true
                CSlider.isHidden = true
                progSlider.isHidden = false
                filterView.isHidden = false
                
            }
            
            if active == 3 {
                filterView.isHidden = true
                sview.isHidden = true
                CSlider.isHidden = true
                self.performSegue(withIdentifier: "toCrop", sender: self)
            }
            
        } else {
            if (active == 1){
                let filter = filters[indexPath.row]
                selected.append(filter)
                let res = multiApply(filters: selected)
                print(selected) // apply multiple
                
                
                imgView.image = res
                filterView.reloadData()
                
            } else if (active == 2) { // only case when we decide what will be hidden (vibrance and color view)
                imgView.image = img!
                filterView.reloadData()
                
                if indexPath.row == 0 {
                    progSlider.isHidden = false // P
                    sview.isHidden = true
                    CSlider.isHidden = true
                } else {
                    sview.isHidden = false
                    CSlider.isHidden = false
                    progSlider.isHidden = true
                }
            } else if active == 3 {
                
            }
            
        }
    }
    
    
    
    /*---------------6--------------------------------------------FILTERS---------------------------------------------------------
     */
    func apply(filter: String, value:Float) -> UIImage{
        let ci = CIImage(cgImage: (img?.cgImage)!) //CIImage(cgImage: imgView.image!.cgImage!) // CRASH
        let filter = CIFilter(name: filter)
        filter?.setValue(ci, forKey: kCIInputImageKey) // kCIInputSharpnessKey
        let output = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let filtered = UIImage(ciImage: output)
        
        //   let ores = Image(image: filtered)
        //  let weres = ores.toUIImage()
        
        return filtered
    }
    
    
    
    func multiApply(filters: [String]) -> UIImage{
        var ci = CIImage(cgImage: (img?.cgImage)!)
        for name in filters{
            ci = ci.applyingFilter(name)
        }
        
        let filtered = UIImage(ciImage: ci)
        return filtered
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
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCrop"{
            let crop = segue.destination as! CropViewController
            crop.img = self.img!
        }
    }
    
    
    
    
import UIKit

class CropViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
   
    // outlets - 3
    var imgView = UIImageView()
    
    @IBOutlet var cropView: UICollectionView!
 
   
    // variables - 4
    var rotateSlider = FSlider()
    var img: UIImage?
    let overlay = UIView()
    var last = CGPoint.zero // last point
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = img!
        cropView.delegate = self
        cropView.dataSource = self // maybe I do not need this after all....
        cropView.backgroundColor = UIColor.black
        addSlider()
        addImage()
        addCrop()
        initOverlay(x: 0, y: 0)
    }
    
    
    func addCrop(){
        let crop = UIButton()
        crop.setTitle("Crop", for: [])
        crop.frame = CGRect(x: 30, y: 510, width: 60, height: 20)
        crop.setTitleColor(UIColor.green, for: [])
        crop.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        crop.addTarget(self, action: #selector(self.perform(sender:)), for: .touchUpInside)
        view.addSubview(crop)
    }
    
    
    @objc func perform(sender:UIButton!){
        cropTo(view: overlay)
    }
    
    
    func addImage(){
        imgView.image = img!
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 290)
        view.addSubview(imgView)
    }
    
    func addSlider(){
        rotateSlider.frame = CGRect(x: 30, y: 480, width: self.view.frame.width - 30, height: 20)
        rotateSlider.thumbTintColor = UIColor.orange
        rotateSlider.addTarget(self, action: #selector(rslided(sender:)), for: .valueChanged)
        view.addSubview(rotateSlider) // Use FSlider subclass
    }
    
    @objc func rslided(sender: UISlider){
        let val = CGFloat(rotateSlider.value)
        imgView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 3.0 * val)
    }
 
    
    func initOverlay(x: CGFloat, y:CGFloat){
        
        overlay.frame = CGRect(x: 70, y: 70, width: 150, height: 150)
        overlay.layer.borderColor = UIColor.orange.cgColor
        overlay.layer.borderWidth = 2.0
        overlay.isHidden = false // true?
        view.addSubview(overlay)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            last = touch.location(in: self.view) // scrollView
            print(last)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let curr = touch.location(in: view) // self.view
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
        
    }
    /*
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     overlay.isHidden = true
     overlay.frame = CGRect.zero
     }*/
    
    
    func cropTo(view:UIView){
        let cgi = img?.cgImage?.cropping(to: view.frame)
        let croppped = UIImage(cgImage: cgi!)
        imgView.image = croppped
    }
    
    
    func squareCrop(){
        let imga = img!
        var const = (imga.cgImage?.width)!
        
        if (imga.cgImage?.width)! > (imga.cgImage?.height)!{
            const = (imga.cgImage?.height)!
        } else {
            const = (imga.cgImage?.width)!
        }
        
        let crop = CGRect(x: 0, y: 0, width: const , height: const)
        let ref = img?.cgImage?.cropping(to: crop)
        let res = UIImage(cgImage: ref!)
        imgView.image = res
    }
    
    
    func ratioCrop(a:Int, b:Int){
  
        let imga = img!
        let total = a + b // 2:3 ->  2 + 3 = 5
        
        let const = (imga.cgImage?.width)! / total // 300 / 5 => 60
        
        var crop = CGRect(x: 0, y: 0, width: const , height: const)
    
        if (imga.cgImage?.width)! > (imga.cgImage?.height)!{
            crop = CGRect(x: 0, y: 0, width: const * 2 , height: const * 3)
        } else {
            crop = CGRect(x: 0, y: 0, width: const * 3 , height: const * 2)
        }
        
        
        let ref = img?.cgImage?.cropping(to: crop)
        let res = UIImage(cgImage: ref!)
        imgView.image = res
    }
    
    
    
 
    
    let aside = ["1", "2", "F"]  // width
    let bside = ["1", "3", "B"]  // height
    
    
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
            squareCrop()
        } else if indexPath.row == 1 {
            ratioCrop(a: 2, b: 3) // 0.5 argument not used
        } else if indexPath.row == 2{
            ratioCrop(a: 3, b: 7) // FB Cover
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShare" {
            let edit = segue.destination as! ShareViewController
            edit.img = self.imgView.image
        }
    }
    
    
    
import UIKit

class ShareViewController: UIViewController {

    var img: UIImage?
   
    @IBAction func share(_ sender: Any) {
        let act = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        present(act, animated: true, completion: nil)
    }
    
}






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


class Grayscale: Filter{
    func apply(input: Image) -> Image {
        return input.transform(cb: { (p:Pixel) -> Pixel in
            let i = p.averageIntensity
            return Pixel(r: i, g: i, b: i)
        })
    }
}


class Saturation:Filter { // instead of Vibrance
    var value: Double = 0.0
    var min: Double = 0.0
    var max:Double = 0.0
    
    // let initial:Double = 0.0
    
    init(value: Double){ // min 0.0, max: 4.0, def: 1.5
        self.value = value
    }
    
    func apply(input: Image) -> Image {
        return input.transform(cb: { (p:Pixel) -> Pixel in
        
            let hsl = HSLPixel()
            let new = UIColor(hue: hsl.h, saturation: CGFloat(hsl.s) * CGFloat(self.value), brightness: hsl.l, alpha: hsl.a)
          
            return Pixel(uiColor: new)
        })
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
        self.value = 0.0
        self.tintColor = UIColor.orange
        self.thumbTintColor = UIColor.blue
        self.isContinuous = true
        self.backgroundColor = UIColor.black
    } // frame target, hidden
}
