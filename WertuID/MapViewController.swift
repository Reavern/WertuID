//
//  MapViewController.swift
//  WertuID
//
//  Created by Reavern on 3/18/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    var temp: URL!
   
    
    
    var mapData = MapDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapData.change(inUrl: temp)
        self.mapData.downloadData {
            self.updateMap()
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
