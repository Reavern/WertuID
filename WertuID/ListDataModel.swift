//
//  ListDataModel.swift
//  WertuID
//
//  Created by Reavern on 3/18/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import Foundation
import Alamofire

class ListDataModel {
    private var _country: [String] = []
    private var _city: [String] = []
    private var _location: [String] = []
    private var _latitude: [String] = []
    private var _longitude: [String] = []
    private var _cityCount: [String] = []
    private var _count: [String] = []
    let url_count = URL(string: "http://reavern.esy.es/JSON/wertu_count/index.php")
    var url = ""
 
    init(inURL: String) {
        url = "http://reavern.esy.es/JSON/wertu_list/" + inURL + "index.php"
    }
    
    var country: [String] {
        return _country 
    }
    
    var city: [String] {
        return _city 
    }
    
    var location: [String] {
        return _location 
    }
    
    var latitude: [String] {
        return _latitude 
    }
    
    var longitude: [String] {
        return _longitude 
    }
    
    var cityCount: [String] {
        return _cityCount 
    }
    
    var count: [String] {
        return _count
    }
    
    
    func downloadData(completed: @escaping ()-> ()) {

        Alamofire.request(url).responseJSON {
            response in
            
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                for data in value as! [[String:AnyObject]] {
                    self._country.append((data["country"] as? String)!)
                    self._city.append((data["city"] as? String)!)
                    self._location.append((data["location"] as? String)!)
                    self._latitude.append((data["latitude"] as? String)!)
                    self._longitude.append((data["longitude"] as? String)!)
                }
            }
            completed()
        }
    }
    
    func countData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url_count!).responseJSON {
            response in
            
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                for data in value as! [[String:AnyObject]] {
                    self._cityCount.append((data["city"] as? String)!)
                    self._count.append((data["count"] as? String)!)
                }
            }
            completed()
        }
    }
    
}
