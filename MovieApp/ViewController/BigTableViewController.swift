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
    
    var smallControllers = [
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
        setNavigationBar()
        setTableView()
        movieDataBase.valueChanged = {
            DispatchQueue.main.async {
                self.bigView.tableView.reloadData()
            }
        }
        movieDataBase.onError = { error in
            print(error)
        }
        movieDataBase.loadData()
    }
    //MARK:-setNaviagationBar
    func setNavigationBar(){
        title = "電影"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
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
        print(smallControllers.count)
        return smallControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:PhotoTableViewCell.reuseidentifier, for: indexPath) as! PhotoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let photoTableCells = cell as! PhotoTableViewCell
        
        ///set the smallViewController
        self.addChild(self.smallControllers[indexPath.row])
        self.smallControllers[indexPath.row].didMove(toParent: self)
        
        photoTableCells.contentView.addSubview(smallControllers[indexPath.row].smallView)
        
        smallControllers[indexPath.row].smallView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        print(smallControllers[indexPath.row].smallView.frame)
        ///set the smallViewController's view equal to photoTableCell
//        self.smallControllers[indexPath.row].smallView.collectionView.frame = photoTableCells.bounds
//        print(photoTableCells.bounds)

    }
}
