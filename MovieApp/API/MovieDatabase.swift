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
    
     var movies:[MovieData] = [] {
        didSet {
            valueChanged?()
        }
    }
    
    func loadData() {
        MovieAPI.readTheAPIKey()
        MovieAPI.shared.getMovieData(callBy: .releaseDateStart("2019-10-10"),.releaseDateStop("2020-10-10")){ Result in
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
    ///網路請求後，再把數據給主執行緒去渲染畫面
    func numberOfRowInSection(_ section: Int) -> Int {
        print("接收的資料數：\(String(movies.count))")
        return movies.count == 0 ? 0 : movies[section].results.count
        
    }
    
    func getMovie(at indexPath: IndexPath) -> MovieData.Result {
        return movies[indexPath.section].results[indexPath.row]
    }
    
}
