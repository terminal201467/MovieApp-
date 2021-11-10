//
//  MovieView.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/4.
//

import UIKit
import SnapKit

class MovieView: UIView {

    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.tableFooterView = Footer()
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //SnapKit..AutoLayout
    func autoLayout(){
        tableView.snp.makeConstraints{ (make) ->Void in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

}
