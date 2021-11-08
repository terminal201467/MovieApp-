//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/4.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let layout:UICollectionView = {
        let layout = UICollectionView()
        layout.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return layout
    }()
    
}
