//
//  ButtonTableViewCell.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/8.
//

import UIKit
import SnapKit

class ButtonTableViewCell: UITableViewCell {
    
    static let identifier = "ButtonFlowCell"
    
    //MARK:-setCollectionView
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ButtonCollectionView.self,forCellWithReuseIdentifier: "Cell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        collectionView.snp.makeConstraints{make in
            make.top.height.equalTo(20)
            make.right.width.equalTo(20)
            make.bottom.height.equalTo(20)
            make.left.width.equalTo(20)
        }
        
    }

}
