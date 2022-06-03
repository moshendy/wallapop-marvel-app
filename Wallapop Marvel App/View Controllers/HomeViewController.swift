//
//  HomeViewController.swift
//  Wallapop Marvel App
//
//  Created by Mohamed Shendy on 03/06/2022.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    let requestURL = ApisURL.apiUrl+ApisURL.comicUrl+ApisURL.apiKey+"&offset=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        AF.request(requestURL, method: .get,encoding: URLEncoding.httpBody, headers: ApisURL._headers)
            .responseJSON { response  in
                
                switch response.result {
                case .success(let value):
                    
                    let responseJSON = JSON(value)
                    if response.response?.statusCode == 200{
//                        print(responseJSON["data"]["results"])
                        
                        let mainJSON = Mapper<Comic>().mapArray(JSONArray: responseJSON["data"]["results"].rawValue as! [[String : Any]])
                        print(mainJSON[1].thumbnail?.path ?? "")
                        print(mainJSON[1].title)

                        
                        
                    }else if response.response?.statusCode == 401{
                        print("failure 401")

                    }else{
                        print("failure else")
                    }
                case .failure(_):
                    print("failure")
                }
            }

    }

    override func viewWillDisappear(_ animated: Bool) {
        
    }

}
