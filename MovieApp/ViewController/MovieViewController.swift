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
        ///LoadingAPIKey
        database.valueChanged = {
            DispatchQueue.main.async {
                self.movieView.tableView.reloadData()
            }
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
}

//MARK:-setTableView
extension MovieViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.reuseidentifier, for: indexPath) as! PhotoTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if let cell = cell as? PhotoTableViewCell{
                cell.collectionView.delegate = self
                cell.collectionView.dataSource = self
                cell.collectionView.reloadData()
            }
        }
    }
}
//MARK:-setCollectionView
extension MovieViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.numberOfRowInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let movie = database.getMovie(at: indexPath)
        let photo = movie.poster_path
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + photo)!
        cell.movieTitle.text = movie.original_title
        cell.imageView.kf.setImage(with: url)
        cell.imageView.kf.indicatorType = .activity
        return cell
    }
}
