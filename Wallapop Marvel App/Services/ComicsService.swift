//
//  WebService.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper


protocol ComicsServiceProtocol {
    func getComics(offset: Int,completion: @escaping (_ success: Bool, _ results: Comics?, _ mainContainer: ComicDataContainer?, _ error: String?) -> ())
    func getComicsByTitle(offset: Int,title: String,completion: @escaping (_ success: Bool, _ results: Comics?, _ mainContainer: ComicDataContainer?, _ error: String?) -> ())

}

class ComicsService: ComicsServiceProtocol {
    
    func getComics(offset: Int,completion: @escaping (Bool, Comics?,ComicDataContainer?, String?) -> ()) {
        
        let apiURL = "\(ApisURL.apiUrl)\(ApisURL.comicUrl)\(ApisURL.apiKey)&offset=\(offset)"
        AF.request(apiURL, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        let mainContainer = Mapper<ComicDataContainer>().map(JSON: responseJSON["data"].rawValue as! [String : Any])
                        
                        completion(true, mainJSON,mainContainer, nil)
                    }else{
                        completion(false, nil, nil, "Error: Trying to parse Comics to model")
                    }
                case .failure(_):
                    completion(false, nil, nil, "Error: Api Failure")
                }
            }
    }
    func getComicsByTitle(offset: Int,title: String,completion: @escaping (Bool, Comics?,ComicDataContainer?, String?) -> ()) {
        
        let apiURL = "\(ApisURL.apiUrl)\(ApisURL.comicUrl)\(ApisURL.apiKey)&offset=\(offset)&titleStartsWith=\(title)"
        AF.request(apiURL, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        let mainContainer = Mapper<ComicDataContainer>().map(JSON: responseJSON["data"].rawValue as! [String : Any])
                        
                        completion(true, mainJSON,mainContainer, nil)
                    }else{
                        completion(false, nil, nil, "Error: Trying to parse Comics to model")
                    }
                case .failure(_):
                    completion(false, nil, nil, "Error: Api Failure")
                }
            }
    }

}
