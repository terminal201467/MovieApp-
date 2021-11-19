//
//  Model.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation

//MARK:-MovieData
struct MovieData:Decodable {
    let status:String
    let copyright:String
    let has_more:Bool
    let num_results:Int
    let results:[Results]
    
    struct Results:Decodable {
        let display_title:String
        let mpaa_rating:String
        let critics_pick:Int
        let byline:String
        let headline:String
        let summary_short:String
        
        let publication_date:String
        let opening_date:String?
        let date_updated:String
        
        let link:Link
        let multimedia:Multimedia?
    }
    struct Link:Decodable {
        let type:String
        let url:URL
        let suggested_link_text:String
    }
    struct Multimedia:Decodable {
        let type:String
        let src:URL
        let height:Int
        let width:Int
    }
}

//MARK:-InternetError
enum InternetError:Error{
    case invalidURL
    case requestFailed
    case invalidData
    case invalidResponse
}


