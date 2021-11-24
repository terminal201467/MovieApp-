//
//  SmallCollectionViewController.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/23.
//

import UIKit

class SmallCollectionViewController: UIViewController {

    //MARK:-Properties
    let smallView:SmallView = .init()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        loadView()
        setCollectionView()
        print("Ya")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-movieData
    let movieDataBase = MovieDatabase()
    
    //MARK:-LifeCycle
    
    override func loadView() {
        super.loadView()
        view = smallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:-setCollectionView
    func setCollectionView(){
        smallView.collectionView.delegate = self
        smallView.collectionView.dataSource = self
    }
}

//MARK:-setCollectionView
extension SmallCollectionViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDataBase.numberOfRowInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseidentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let movie = movieDataBase.getMovie(at: indexPath)
        let photo = movie.poster_path
        let url = URL(string: movieImageURL + photo)
        
        cell.imageView.kf.setImage(with: url)
        cell.movieTitle.text = movie.original_title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: smallView.collectionView.frame.width, height: smallView.collectionView.frame.height)
        return itemSize
    }
}
