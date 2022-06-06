//
//  MockComicService.swift
//  Wallapop Marvel AppTests
//
//  Created by Mohamed Shendy on 05/06/2022.
//
import Foundation
import ObjectMapper
import SwiftyJSON

@testable import Wallapop_Marvel_App

class MockComicServiceProtocol: ComicsServiceProtocol {
    func getComicsByTitle(offset: Int, title: String, completion: @escaping (Bool, Comics?, ComicDataContainer?, String?) -> ()) {
        if offset == 1{
            if let path = Bundle.main.path(forResource: "comicsExample", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String: Any]
                    let x = JSON(jsonResult)
                    let mainContainer = Mapper<ComicDataContainer>().map(JSON: x["data"].rawValue as! [String : Any])
                    let mainJSON = Mapper<Comic>().mapArray(JSONArray: x["data"]["results"].rawValue as! [[String : Any]])
                    completion(true, mainJSON,mainContainer, "Success: 200")
                  } catch {
                       // handle error
                      completion(false, nil,nil, "Success: 200")
                  }
            }else{
                print("here")
            }
        }else if offset == 2{
            completion(false, nil, nil, "Error: Api Failure")
        }else{
            completion(false, nil, nil, "Error: 500")
        }
    }
    func getComics(offset: Int, completion: @escaping (Bool, Comics?, ComicDataContainer?, String?) -> ()) {
        if offset == 1{
            if let path = Bundle.main.path(forResource: "comicsExample", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String: Any]
                    let x = JSON(jsonResult)
                    let mainContainer = Mapper<ComicDataContainer>().map(JSON: x["data"].rawValue as! [String : Any])
                    let mainJSON = Mapper<Comic>().mapArray(JSONArray: x["data"]["results"].rawValue as! [[String : Any]])
                    completion(true, mainJSON,mainContainer, "Success: 200")
                  } catch {
                       // handle error
                      completion(false, nil,nil, "Success: 200")
                  }
            }else{
                print("here")
            }
        }else if offset == 2{
            completion(false, nil, nil, "Error: Api Failure")
        }else{
            completion(false, nil, nil, "Error: 500")
        }
    }
    
}
