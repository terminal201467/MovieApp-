//
//  MovieAPI.swift
//  MovieApp
//
//  Created by Jhen Mu on 2021/11/3.
//

import Foundation
import Alamofire

//https://api.nytimes.com/svc/movies/v2/reviews/search.json
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
    private let baseURL = "https://api.themoviedb.org/3/movie"
    
    //MARK:-Methods
    //BuildRequest
    private func buildRequest(callBy:CallMethod) ->URLRequest{
        var components = URLComponents(string:baseURL)
        var parameter = callBy.parameters
        parameter["api_key"] = apikey
        components?.queryItems = parameter.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
        return URLRequest(url:components!.url!, timeoutInterval: 10)
    }
    
    //GetData
    func getSearchData(callBy:CallMethod,completion:@escaping(Result<MovieData,Error>)->Void){
        let request = buildRequest(callBy:callBy)
        URLSession.shared.dataTask(with: request){data,_,error in
            if let error = error{
                completion(.failure(error))
            }
            if let data = data{
                do{
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
        case actorNumber(Int)
        
        var parameter:[String:Any]{
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
        case .actorNumber(let actorNumber):
            return ["with_people":actorNumber]
            }
        }
    }
}




