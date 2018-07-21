    var slider: UISlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        slider = UISlider()
        slider.frame = CGRect(x: 30, y: 60, width: view.frame.width - 30, height: 20)
        // slider.center = self.view.center
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        slider.tintColor = UIColor.orange
        slider.thumbTintColor = UIColor.blue
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(slide(sender:)), for: .valueChanged)
        view.addSubview(slider)
    }
    
    
    @objc func slide(sender: UISlider){
        print(slider.value)
    }
