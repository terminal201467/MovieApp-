//
//  BigView.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/23.
//

import UIKit
import SnapKit

class BigView: UIView {
    
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    //MARK:-Intialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout(){
        tableView.snp.makeConstraints{mask in
            mask.top.bottom.right.left.equalToSuperview()
        }
    }

}
