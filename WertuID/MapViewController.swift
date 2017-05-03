//
//  MapViewController.swift
//  WertuID
//
//  Created by Reavern on 3/18/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class MapViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var coordinateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var temp: URL!
    var mapData = MapDataModel()
    var fav = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()

        self.mapData.change(inUrl: temp)
        self.mapData.downloadData {
            self.updateMap()
            self.UpdateUI()
            SVProgressHUD.dismiss()
        }
    }

    func UpdateUI() {
        cityLabel.text = mapData.city + ", " + mapData.country
        coordinateLabel.text = "lat: " + String(mapData.latitude) + ", long: " + String(mapData.longitude)
    }
    
    func updateMap() {
        googleMapView.camera = GMSCameraPosition.camera(withLatitude: mapData.latitude, longitude: mapData.longitude, zoom: 5)
        googleMapView.animate(toZoom: 15)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(mapData.latitude, mapData.longitude)
        marker.title = mapData.city + ", " + mapData.country
        marker.snippet = mapData.location
        marker.map = googleMapView
    }
    
    @IBAction func addToFavouritesButton(_ sender: Any) {
        let check = String(describing: temp)
        if let data = UserDefaults.standard.object(forKey: "FAV") as? [String]{
            if !data.contains(check) {
                print("B")
                fav = data
                fav.append(check)
                UserDefaults.standard.set(fav, forKey: "FAV")
            }
            
        }
        else {print("C")
            fav.append(check)
            UserDefaults.standard.set(fav, forKey: "FAV")
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
