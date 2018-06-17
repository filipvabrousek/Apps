//
//  ViewController.swift
//  BarChartLiveStream
//
//  Created by Brian Voong on 3/12/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let values: [CGFloat] = [200, 330, 400, 800] // dist * 100 (

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)
        
        (collectionView?.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    func maxHeight() -> CGFloat {
        return view.frame.height - 20 - 44 - 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BarCell
        
        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max
            
            cell.barHeightConstraint?.constant = maxHeight() * ratio
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: maxHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }

}













//
//  BarCell.swift
//  BarChartLiveStream
//
//  Created by Brian Voong on 3/19/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

class BarCell: UICollectionViewCell {
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override var isHighlighted: Bool {
        didSet {
            barView.backgroundColor = isHighlighted ? .black : .red
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(barView)
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightConstraint?.isActive = true
        barHeightConstraint?.constant = 100
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
