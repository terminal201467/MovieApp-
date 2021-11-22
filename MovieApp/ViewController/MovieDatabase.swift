//
//  MovieData.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/11.
//

import Foundation

class MovieDatabase {
    
    var onError: ((Error) -> Void)?
    var valueChanged: (() -> Void)?
    
    private var movies:[MovieData] = [] {
        didSet {
            valueChanged?()
        }
    }
    
    func loadData() {
        MovieAPI.readTheAPIKey()
        MovieAPI.shared.getMovieData(callBy: .releaseDateStart("2014-10-10")){ Result in
            switch Result{
            case .success(let movieData):
                self.movies.append(movieData)
            case .failure(let error):
                self.onError?(error)
            }
        }
    }

    var numberOfSection: Int {
        return movies.count
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        return movies[section].results.count
    }
    
    func getMovie(at indexPath: IndexPath) -> MovieData.Results {
        return movies[indexPath.section].results[indexPath.row]
    }
    
}
