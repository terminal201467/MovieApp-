//
//  AlamofireGet.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation
import Alamofire

class AlamofirePhotoGet {
    
    static var shared:AlamofirePhotoGet = .init()
    
    func MovieDataGet(url:String){
        AF.request(url).response{ response in
            debugPrint(response)
            
            
        }
    }
}

