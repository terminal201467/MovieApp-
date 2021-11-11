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
    ///collectionViewCell
    let photoTableCollectionViewCell:PhotoTableViewCell = .init()
    ///movieDataArray
    let database = MovieDatabase()
    
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
        database.valueChanged = {
            self.movieView.tableView.reloadData()
        }
        database.onError = { error in
            print(error)
        }
        database.loadData()
        
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
        return database.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.backgroundColor = .blue

        return cell
    }
}

//MARK:-setCollectionView
extension MovieViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.numberOfRowInSection(section)
    }
    
    //Didn't Trigger
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///not trigger......
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        ///WhenCanGetThePhotoAndStore
        let movie = database.getMovie(at: indexPath)
        let photoURL = movie.multimedia?.src
        print("下載網址:\(photoURL)")
        ///Now the most important is that How to download the photo to local
        cell.imageView.kf.setImage(with:photoURL)
        cell.imageView.kf.indicatorType = .activity
        return cell
    }
}

