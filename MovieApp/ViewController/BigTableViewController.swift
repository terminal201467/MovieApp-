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
    func setTableView(){
        bigView.tableView.delegate = self
        bigView.tableView.dataSource = self
    }
}

extension BigTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
    
    
    
}
