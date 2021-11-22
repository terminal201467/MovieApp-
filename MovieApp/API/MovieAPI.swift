//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation
import Alamofire

class MovieAPI{
    //MARK:-Singleton
    static var shared:MovieAPI!
    
    ///the API key where Intailize
    private init(apikey:String){
        self.apikey = apikey
    }
    
    ///let the Movie API get the api key
    static func configure(apikey:String){
        MovieAPI.shared = MovieAPI(apikey: apikey)
    }
    
    //MARK:-LoadAPIKey
    static func readTheAPIKey(){
        if let url = Bundle.main.url(forResource: "APIKey", withExtension: "bundle"),
           let bundle = Bundle(url: url),
           let path = bundle.path(forResource: "apikey", ofType: "txt"){
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let apiKey = data.components(separatedBy: .newlines).joined()
                MovieAPI.configure(apikey: apiKey)
            }catch {
                print(error.localizedDescription)
            }
        }
    }

    //MARK:-Properties
    private var apikey:String
    private let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    //MARK:-Methods
    //BuildRequest
    //可以選擇性傳入多的parameter
    
    //OneParameter
    private func buildRequest(callBy:[CallMethod]) ->URLRequest{
        var components = URLComponents(string:baseURL)
        var query:[String:Any] = [:]
        callBy.map{$0.parameters.map{query[$0.key] = $0.value}}
        query["api_key"] = apikey
        components?.queryItems = query.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
        return URLRequest(url:components!.url!, timeoutInterval: 10)
    }
    
    //GetData
    func getMovieData(callBy:CallMethod...,completion:@escaping(Result<MovieData,Error>)->Void){
        let request = buildRequest(callBy:callBy)
//        print(request)
        URLSession.shared.dataTask(with: request){data,_,error in
            if let error = error{
                completion(.failure(error))
            }
            if let data = data{
                do{
//                    print(String(data: data, encoding: .utf8)!)
                    let decode = try JSONDecoder().decode(MovieData.self,from: data)
                    completion(.success(decode))
                }catch{
                    completion(.failure(error))
                }
            } else {
                completion(.failure(InternetError.invalidData))
            }
        }.resume()
    }
    
}

extension MovieAPI{
    enum CallMethod{
        case releaseDateStart(String)
        case releaseDateStop(String)
        case primaryReleaseYear(String)
        case sortBy(String)
        case certificateCountry(String)
        case certification(String)
        case gener(Int)
        case cast(Int)
        case actorNameNumber(Int)
        
        var parameters:[String:Any]{
        switch self{
        case .releaseDateStart(let releaseDateStart):
            return ["primary_release_date.gte":releaseDateStart]
        case .releaseDateStop(let releaseDateStop):
            return ["primary_release_date.lte":releaseDateStop]
        case .primaryReleaseYear(let primaryReleaseYear):
            return ["primary_release_year":primaryReleaseYear]
        case .sortBy(let sortBy):
            return ["sort_by":sortBy]
        case .certificateCountry(let certificateCountry):
            return ["certification_country":certificateCountry]
        case .certification(let certification):
            return ["certification.lte":certification]
        case .gener(let gener):
            return ["with_genres":gener]
        case .cast(let cast):
            return ["cast":cast]
        case .actorNameNumber(let actorNameNumber):
            return ["with_people":actorNameNumber]
            }
        }
    }
}




