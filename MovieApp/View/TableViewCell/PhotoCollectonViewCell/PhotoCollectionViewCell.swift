//
//  PhotoCollectionViewCell.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/8.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionCell"
    
    var imageView:UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        contentView.addSubview(imageView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        imageView.snp.makeConstraints{(mask)->Void in
            mask.top.bottom.left.right.equalToSuperview()
        }
    }
}
