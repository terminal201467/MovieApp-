//
//  SmallCollectionViewController.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/23.
//

import UIKit

class SmallCollectionViewController: UIViewController, UICollectionViewDelegate {

    //MARK:-Properties
    let smallView:SmallView = .init()
    
    //MARK:-movieData
    let movieDataBase = MovieDatabase()
    
    
    //MARK:-LifeCycle
    
    override func loadView() {
        super.loadView()
        view = smallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    //MARK:setCollectionView
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let movie = movieDataBase.getMovie(at: indexPath)
        let photo = movie.poster_path
        let url = URL(string: movieImageURL + photo)
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: 100, height: smallView.collectionView.frame.height)
        return itemSize
    }
    
    
    
    

    

    
    
    
    
    
}
