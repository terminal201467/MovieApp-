//
//  IntroduceViewController.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/23.
//

import UIKit

class BigTableViewController: UIViewController {

    //MARK:-Properties
    let bigView:BigView = .init()
    
    //MARK:-dataBase
    let movieDataBase = MovieDatabase()
    
    var controllers = [
        SmallCollectionViewController(),
        SmallCollectionViewController(),
        SmallCollectionViewController(),
        SmallCollectionViewController()
    ]
    
    //MARK:-LifeCycle
    override func loadView() {
        super.loadView()
        view = bigView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
    }
    
    //MARK:-setTableView
    func setTableView(){
        bigView.tableView.delegate = self
        bigView.tableView.dataSource = self
    }
}

//MARK:-setTableViewDelegateDataSource
extension BigTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:PhotoTableViewCell.reuseidentifier, for: indexPath) as! PhotoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let photoTableCells = cell as! PhotoTableViewCell
        self.controllers[indexPath.row].smallView.collectionView.frame = photoTableCells.bounds
        self.addChild(self.controllers[indexPath.row])
        self.controllers[indexPath.row].didMove(toParent: self)
        photoTableCells.addSubview(controllers[indexPath.row].smallView)
    }
}
