//
//  Model.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation

//MARK:-MovieData
struct MovieData:Decodable {
    var page:Int
    var results:[Result]
    
    struct Result:Decodable {
        var adult:Bool
        var backdrop_path:String
        var original_language:String
        var original_title:String
        var overview:String
        var popularity:Double
        var poster_path:String
        var release_date:String
    }
}


//MARK:-InternetError
enum InternetError:Error{
    case invalidURL
    case requestFailed
    case invalidData
    case invalidResponse
}

let movieImageURL:String = ""

