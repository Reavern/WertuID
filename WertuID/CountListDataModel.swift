//
//  CountListDataModel.swift
//  WertuID
//
//  Created by Reavern on 3/19/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import Foundation
import Alamofire

class CountListDataModel {
    private var _city: [String] = []
    private var _count: [String] = []
    let url = URL(string: "http://reavern.esy.es/JSON/wertu_count/index.php")
    
    func downloadData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url!).responseJSON {
            response in
            
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                for data in value as! [[String:AnyObject]] {
                    self._city.append((data["city"] as? String)!)
                    self._count.append((data["count"] as? String)!)
                }
            }
            completed()
        }
    }
}
