//
//  PhotoCollectionViewCell.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/8.
//

import UIKit
import SnapKit

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
    
//    let label:UILabel = {
//        var label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textAlignment = .center
//        label.numberOfLines = 1
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        ///why not trigger......
        contentView.addSubview(imageView)
//        contentView.addSubview(stackView)
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
