//
//  SmallView.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/23.
//

import UIKit

import SnapKit

class SmallView: UIView {
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //collectionView
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //layout
        layout.itemSize = CGSize(width: 100, height: collectionView.frame.height)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize.zero
        return collectionView
    }()

    //MARK:-Intialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        collectionView.snp.makeConstraints{mask in
            mask.top.bottom.left.right.equalToSuperview()
        }
    }

}
