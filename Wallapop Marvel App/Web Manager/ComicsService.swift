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
    func getComics(completion: @escaping (_ success: Bool, _ results: Comics?, _ error: String?) -> ())
}

class ComicsService: ComicsServiceProtocol {
    
    func getComics(completion: @escaping (Bool, Comics?, String?) -> ()) {
        AF.request(ApisURL.apiUrl+ApisURL.comicUrl+ApisURL.apiKey, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        completion(true, mainJSON, nil)
                    }else{
                        completion(false, nil, "Error: Trying to parse Comics to model")
                    }
                case .failure(_):
                    completion(false, nil, "Error: Api Failure")
                }
            }
    }
}
