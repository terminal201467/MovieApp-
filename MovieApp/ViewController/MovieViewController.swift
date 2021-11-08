//
//  ViewController.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK:-Properties
    ///View
    let movieView:MovieView = .init()
    
    ///movieDataArray
    var movieArray:[MovieData] = []
    
    //MARK:-LifeCycle
    
    override func loadView() {
        super.loadView()
        view = movieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        ///LoadingAPIKey
        MovieAPI.readTheAPIKey()
        ///GetAPI
        MovieAPI.shared.getSearchData(callBy: .query("godfather")){ Result in
            switch Result{
            case .success(let MovieData):
                print("請求的電影資料：\(MovieData)")
                self.movieArray.append(MovieData)
            case .failure(let InternetError):
                print("錯誤訊息:\(InternetError.localizedDescription)")
            }
        }
    }
    
    //MARK:-SetTableView
    func setTableView(){
        movieView.tableView.delegate = self
        movieView.tableView.dataSource = self
    }
    
    func setCollectionView(){
        
    }
}

extension MovieViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        ///need to custom a cell transe to a collectionView
        
        return cell
    }
    
}

