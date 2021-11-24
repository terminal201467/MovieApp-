//
//  ButtonCollectionView.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/8.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "SimpleCollection"
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.estimatedItemSize = .zero
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        collectionView.snp.makeConstraints{mask in
            mask.top.bottom.right.left.equalToSuperview()
        }
    }
}
