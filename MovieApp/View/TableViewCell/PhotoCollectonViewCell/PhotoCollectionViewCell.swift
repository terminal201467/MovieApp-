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
    
    static let reuseidentifier = "PhotoCollectionCell"
    
    var imageView:UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    var movieTitle:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,movieTitle])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(stackView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        stackView.snp.makeConstraints{(mask)->Void in
            mask.top.bottom.left.right.equalToSuperview()
        }
    }
}
