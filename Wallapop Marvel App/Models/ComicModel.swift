//
//  Comics.swift
//  Wallapop Techincal Test
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import Foundation
import ObjectMapper


typealias Comics = [Comic]


//MARK: - Comic Data Container Model
//--------------------------------
class ComicDataContainer: Mappable{
    var offset: Int = 0
    var limit: Int = 0
    var total: Int = 0
    var count: Int = 0

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        offset <- map["offset"]
        limit <- map["limit"]
        total <- map["total"]
        count <- map["count"]
    }
}

//MARK: - Comic Model
//--------------------------------
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

//MARK: - Comic Thumbnail Model
//--------------------------------
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

//MARK: - Comic Prices Model
//--------------------------------
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

//MARK: - Comic Creators Model
//--------------------------------
class CreatorSummary: Mappable{
    
    var name: String = ""
    
    required init?(map: Map){
    }
    func mapping(map: Map) {
        name <- map["name"]
    }
}

