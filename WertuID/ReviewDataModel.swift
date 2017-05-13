//
//  ReviewDataModel.swift
//  WertuID
//
//  Created by Reavern on 5/13/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import Foundation
import Alamofire

class ReviewDataModel {
    var chat: [String] = []
    private var url: URL?
    
    func change(inUrl: URL) -> () {
        url = inUrl
    }
    
    func downloadData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url!).responseJSON {
            response in
            
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                for data in value as! [[String:AnyObject]] {
                    self.chat.append(data["chat"] as! String)
                }
            }
            completed()
        }
    }
}
