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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        googleMapView.camera = GMSCameraPosition.camera(withLatitude: -6.1745, longitude: 106.8227, zoom: 6.0)
        googleMapView.selectedMarker?.position = CLLocationCoordinate2DMake(-6.1745, 106.8227)
        googleMapView.selectedMarker?.title = "Jakarta"
        googleMapView.selectedMarker?.snippet = "Indonesia"

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
