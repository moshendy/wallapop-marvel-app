//
//  Comics.swift
//  Wallapop Techincal Test
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation
import ObjectMapper


typealias Comics = [Comic]

class Comic: Mappable{
    
    var id: Int = 0
    var title: String = ""
    var variantDescription:String = ""
    var description: String = ""
    var pageCount: Int = 0
    var prices: [ComicPrice]?
    var creatorSummary: [CreatorSummary]?
    var thumbnail: Thumbnail?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        variantDescription <- map["variantDescription"]
        description <- map["description"]
        pageCount <- map["pageCount"]
        prices <- map["prices"]
        thumbnail <- map["thumbnail"]

    }


}
class Thumbnail: Mappable{
    
    var path: String = ""
    var ext: String = ""
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        path <- map["path"]
        ext <- map["extension"]
    }

}

class ComicPrice: Mappable{
    
    var type: String = ""
    var price: Double = 0.0
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        price <- map["price"]
        type <- map["type"]
    }

}
class CreatorSummary: Mappable{
    
    var name: String = ""
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }

}

