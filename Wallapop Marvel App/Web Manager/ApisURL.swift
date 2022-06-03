//
//  ApisURL.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

struct ApisURL{
    
    static let apiUrl: String = "http://gateway.marvel.com/v1/public"
    static let apiKey: String = "?apikey=593c11b7b53136be76d7ee6d6e838de4&hash=67db6b5d84c86f1cf8ce7de72a73a8c3&ts=1"
    static let _headers : HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded","Accept":"application/json"]

    static let imageExt: String = "/portrait_incredible."
    
    static let comicUrl: String = "/comics"
}
