//
//  Model.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation

struct webSite {
    var url = ""
    var apiKey = "D6Tl9AQ6SxnWJrHCmlJI7RUSjoxQayLe"
}

//MARK:-MovieData
struct MovieData:Decodable {
    let status:String
    let copyRight:String
    let has_more:Bool
    let num_result:Int
    let results:[Results]
}
struct Results:Decodable {
    let display_title:String
    let mpaa_rating:String
    let critic_pick:Int
    let byline:String
    let headline:String
    let summary_short:String
    let publication_date:Date
    let opening_updated:Date
    let link:Link
    let multimedia:Multimedia
}
struct Link:Decodable {
    let type:String
    let url:URL
    let suggest_link_text:String
}
struct Multimedia:Decodable {
    let type:String
    let src:URL
    let height:Int
    let weight:Int
}

//MARK:-InternetError
enum InternetError:Error{
    case invalidURL
    case requestFailed
    case invalidData
    case invalidResponse
}


//MARK:-EnumTheSection
///notTotallySetUp
enum Movie{
    case game
    case reviewer
}

