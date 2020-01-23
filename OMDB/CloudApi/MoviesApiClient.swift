//
//  MoviesApiClient.swift
//  OMDB
//
//  Created by Mahesh Sherkar on 19/01/20.
//  Copyright © 2020 medianet. All rights reserved.
//

import Foundation

typealias ApiCompletionBlock<T : Decodable> = (ApiResult<T>) -> Void

enum ApiResult<T : Decodable> {
    case success(T)
    case failure(ApiError)
}

enum ApiError : Error {
    case notFound    // 404
    case serverError // 5xx
    case requestError // 4xx
    case responseFormatInvalid(String)
    case connectionError(Error)
}

infix operator -=>

class MoviesApiClient : MoviesDataProviderService {
  
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func executeFetchMoviesListRequest(search: String,
                    completion: @escaping ApiCompletionBlock<MoviesResponseModel>) {
        let url = URL(string: RequestURL.fetchMovies + "&s=" + search)!
        var req = URLRequest(url: url)
        req.httpMethod = "post"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: req) { (data, response, error) in
            if let e = error {
                ApiResult.failure(.connectionError(e)) -=> completion
            } else {
                let http = response as! HTTPURLResponse
                switch http.statusCode {
                case 200:
                    let jsonDecoder = JSONDecoder()
                    do {
                        let response = try jsonDecoder.decode(MoviesResponseModel.self, from: data!)
                        ApiResult.success(response) -=> completion
                    } catch let e {
                        print(e)
                        let bodyString = String(data: data!, encoding: .utf8)
                        ApiResult.failure(.responseFormatInvalid(bodyString ?? "<no body>")) -=> completion
                    }
                    
                default:
                    ApiResult.failure(.serverError) -=> completion
                }
            }
        }
        task.resume()
    }
    
    func executeFetchMoviesDetailsRequest(name: String,
                    completion: @escaping ApiCompletionBlock<MoviesDetailsResponseModel>) {
        var nameforUrl = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var urlPath = RequestURL.fetchMovies + "&t=" + nameforUrl!;        
        let url = URL(string: urlPath)!
        var req = URLRequest(url: url)
        req.httpMethod = "post"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: req) { (data, response, error) in
            if let e = error {
                ApiResult.failure(.connectionError(e)) -=> completion
            } else {
                let http = response as! HTTPURLResponse
                switch http.statusCode {
                case 200:
                    let jsonDecoder = JSONDecoder()
                    do {
                        let response = try jsonDecoder.decode(MoviesDetailsResponseModel.self, from: data!)
                        ApiResult.success(response) -=> completion
                    } catch let e {
                        print(e)
                        let bodyString = String(data: data!, encoding: .utf8)
                        ApiResult.failure(.responseFormatInvalid(bodyString ?? "<no body>")) -=> completion
                    }
                    
                default:
                    ApiResult.failure(.serverError) -=> completion
                }
            }
        }
        task.resume()
    }
    
}

func -=><T>(result: ApiResult<T>, completion: @escaping ApiCompletionBlock<T>) {
    DispatchQueue.main.async {
        completion(result)
    }
}
