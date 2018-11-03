   
    func addStack(){

        let st = UIStackView()
        st.distribution = .fillProportionally
        
        let tst = UIStackView()
        tst.distribution = .equalSpacing
        tst.addArrangedSubview(minSwim)
        tst.addArrangedSubview(dot)
        tst.addArrangedSubview(secSwim)
        
        st.addArrangedSubview(infoswim)
        st.addArrangedSubview(tst)
        
   
        let rt = UIStackView()
        // st.alignment = .fill
        rt.distribution = .fillProportionally
        rt.spacing = 0.5
        let trt = UIStackView()
        trt.distribution = .equalSpacing
        trt.addArrangedSubview(minRun)
        trt.addArrangedSubview(dota)
        trt.addArrangedSubview(secRun)
        
        rt.addArrangedSubview(inforun)
        rt.addArrangedSubview(trt)
        
        let main = UIStackView()
        main.axis = .vertical
        main.distribution = .equalSpacing
        main.addArrangedSubview(nickField)
        main.addArrangedSubview(efield)
        main.addArrangedSubview(st)
        main.addArrangedSubview(rt)
        main.addArrangedSubview(experiencefield)
        
        let v = UIView()
        v.backgroundColor = .orange
        v.alpha = 0.5
        
        view.addSubview(main)
        main.pin(a: .top, b: .left, ac: 60, bc: 30, w: 180, h: 160, to: nil)
    }
