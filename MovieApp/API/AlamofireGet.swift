//
//  AlamofireGet.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation
import Alamofire

class AlamofireMovieGet {
    
    static var shared:AlamofireMovieGet!
    
    func MovieDataGet(){
        AF.request("https://api.nytimes.com").response{ response in
            debugPrint(response)
            
        }
    }
}

