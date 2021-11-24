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
        collectionView.register(PhotoCollectionViewCell.self,forCellWithReuseIdentifier:PhotoCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
//    func createMoviePhotoSize()->NSCollectionLayoutSection{
//        //Item
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
//
//        //Group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
//
//        //Section
//        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//
//        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
//        return layoutSection
//
//    }
    
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

