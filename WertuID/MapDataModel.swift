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
    typealias JSONStandart = Dictionary<String, AnyObject>
    
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

            if let dict = response.result.value as? JSONStandart , let country = dict["country"] as? String, let city = dict["city"] as? String, let location = dict["location"] as? String, let latitude = dict["latitude"] as? Double, let longitude = dict["longitude"] as? Double {

                self._country = country
                self._city = city
                self._location = location
                self._latitude = latitude
                self._longitude = longitude
            }
            completed()
        }
    }
    
    
}
