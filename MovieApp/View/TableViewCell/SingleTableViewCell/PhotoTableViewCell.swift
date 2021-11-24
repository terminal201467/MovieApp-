//
//  PhotoTableViewCell.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/8.
//

import UIKit
import SnapKit

class PhotoTableViewCell: UITableViewCell {
    
    static let reuseidentifier = "PhotoCell"
    
    var collectionView:UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self,forCellWithReuseIdentifier:PhotoCollectionViewCell.reuseidentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        autoLayout()
    }
    
    required init?(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        collectionView.snp.makeConstraints{mask in
            mask.top.bottom.right.left.equalToSuperview()
        }
    }
}

