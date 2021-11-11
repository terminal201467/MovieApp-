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
    private let baseURL = "https://api.nytimes.com/svc/movies/v2/reviews/search.json"
    
    //MARK:-Methods
    //BuildRequest
    private func buildRequest(callBy:CallMethod) ->URLRequest{
        var components = URLComponents(string:baseURL)
        var parameter = callBy.parameters
        parameter["api-key"] = apikey
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
        case criticsPick(String)
        case offSet(Int)
        case openingDate(String)
        case order(String)
        case publicationDate(String)
        case reviewer(String)
        case query(String)
        
        var parameters:[String:Any]{
        switch self{
        case .criticsPick(let criticPick):
            return ["criticPick":criticPick]
            
        case .offSet(let offSet):
            return ["offSet":offSet]
            
        case .openingDate(let openingDate):
            return ["openingDate":openingDate]
            
        case .order(let order):
            return ["order":order]
            
        case .publicationDate(let publicationDate):
            return ["publicationDate":publicationDate]
            
        case .reviewer(let reviewer):
            return ["reviewer":reviewer]
            
        case .query(let query):
            return ["query":query]
            }
        }
    }
    
    enum reviewer:String{
        case all = "all"
        case full_time = "full-time"
        case part_time = "part-time"
    }
    
    enum type:String{
        case all
        case picks
    }
    
}




