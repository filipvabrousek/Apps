 
    func addSlider() {
        var slider = GradientSlider()
        slider.frame = CGRect(x: 30, y: 600, width: view.frame.width - 30, height: 20)
        slider.isContinuous = true
        slider.value = 0.5
        slider.addTarget(self, action: #selector(slide(sender:)), for: .valueChanged)
        view.addSubview(slider)
    }


    class GradientSlider: UISlider {
    
    var thickness: CGFloat = 20 {
        didSet {
            setup()
        }
    }
    
    var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }
    
    func setup() {
        let minTrackStartColor = UIColor.red
        let minTrackEndColor = UIColor.yellow
        let maxTrackColor = UIColor.green
        do {
            self.setMinimumTrackImage(try self.gradientImage(
                size: self.trackRect(forBounds: self.bounds).size,
                colorSet: [minTrackStartColor.cgColor, minTrackEndColor.cgColor]),
                                      for: .normal)
            self.setMaximumTrackImage(try self.gradientImage(
                size: self.trackRect(forBounds: self.bounds).size,
                colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                      for: .normal)
            self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = minTrackStartColor
            self.maximumTrackTintColor = maxTrackColor
        }
        
        print("SZ \(self.bounds.size)")
    }
    
    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)
        
        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =
            
            UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
                UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
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
