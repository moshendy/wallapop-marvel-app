//
//  MockWebService.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 06/06/2022.
//

import Foundation
import Foundation
import ObjectMapper
import SwiftyJSON
import Alamofire

@testable import Wallapop_Marvel_App

class MockWebService: ComicsServiceProtocol {
    func getComicsByTitle(offset: Int, title: String, completion: @escaping (Bool, Comics?, ComicDataContainer?, String?) -> ()) {
        
        let apiURL = "\(ApisURL.apiUrl)\(ApisURL.comicUrl)\(ApisURL.apiKey)&titleStartsWith=\(title)"
        AF.request(apiURL, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        let mainContainer = Mapper<ComicDataContainer>().map(JSON: responseJSON["data"].rawValue as! [String : Any])
                        
                        completion(true, mainJSON,mainContainer, "Success: 200")
                    }else{
                        completion(false, nil, nil, "Error: Api Failure")
                    }
                case .failure(_):
                    completion(false, nil, nil, "Error: 500")
                }
            }
    }
    func getComics(offset: Int, completion: @escaping (Bool, Comics?, ComicDataContainer?, String?) -> ()) {

        let apiURL = "\(ApisURL.apiUrl)\(ApisURL.comicUrl)\(ApisURL.apiKey)"
        AF.request(apiURL, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        let mainContainer = Mapper<ComicDataContainer>().map(JSON: responseJSON["data"].rawValue as! [String : Any])
                        
                        completion(true, mainJSON,mainContainer, "Success: 200")
                    }else{
                        completion(false, nil, nil, "Error: Api Failure")
                    }
                case .failure(_):
                    completion(false, nil, nil, "Error: 500")
                }
            }

    }
}
