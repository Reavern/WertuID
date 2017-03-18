//
//  MapDataModel.swift
//  WertuID
//
//  Created by Reavern on 3/18/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import Foundation
import Alamofire

class MapDataModel {
    private var _country: String?
    private var _city: String?
    private var _location: String?
    private var _latitude: Double?
    private var _longitude: Double?
    private var url: String?
    
    init(inURL:String) {
        self.url = inURL
    }
    
    var country: String {
        return _country ?? "#"
    }
    
    var city: String {
        return _city ?? "#"
    }
    
    var location: String {
        return _location ?? "#"
    }
    
    var latitude: Double {
        return _latitude ?? 0
    }
    
    var longitude: Double {
        return _longitude ?? 0
    }

    
    func downloadData(completed: @escaping ()-> ()) {
        
        let reqURL = URL(string: url!)
        Alamofire.request(reqURL!).responseJSON {
            response in
            
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                for data in value as! [[String:AnyObject]] {
                    self._country = data["country"] as? String
                    self._city = data["city"] as? String
                    self._location = data["location"] as? String
                    self._latitude = data["latitude"]?.doubleValue
                    self._longitude = data["longitude"]?.doubleValue
                }
            }
            completed()
        }
    }
    
    
}
