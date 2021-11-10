//
//  ViewController.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    //MARK:-Properties
    ///View
    let movieView:MovieView = .init()
    
    let photoTableCollectionViewCell:PhotoTableViewCell = .init()
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
        setNavigationBar()
        setCollectionView()
        ///LoadingAPIKey
        MovieAPI.readTheAPIKey()
        ///GetAPI
        MovieAPI.shared.getSearchData(callBy: .query("godfather")){ Result in
            switch Result{
            case .success(let MovieData):
                self.movieArray.append(MovieData)
                print("存進的陣列：\(self.movieArray)")
            case .failure(let InternetError):
                print("錯誤訊息:\(InternetError.localizedDescription)")
            }
        }
    }
    //MARK:-setNavigationBar
    func setNavigationBar(){
        title = "電影"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    //MARK:-SetTableView
    func setTableView(){
        movieView.tableView.delegate = self
        movieView.tableView.dataSource = self
    }
    //MARK:SetCollectionView
    func setCollectionView(){
        photoTableCollectionViewCell.collectionView.delegate = self
        photoTableCollectionViewCell.collectionView.dataSource = self
    }
}

//MARK:-setTableView
extension MovieViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        ///need to custom a cell transe to a collectionView
        cell.backgroundColor = .blue
        
        return cell
    }
}

//MARK:-setCollection
extension MovieViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.map{$0.results}.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        ///WhenCanGetThePhotoAndStore
        let photoURL = URL(string:"\(movieArray.map{$0.results}[indexPath.item].map{$0.multimedia?.src})")
        print("SRC:\(photoURL)")
        cell.imageView.kf.setImage(with:photoURL)
        cell.imageView.kf.indicatorType = .activity
        return cell
    }
}

