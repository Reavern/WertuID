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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var nextTemp = ""
    
    var temp: URL!
    var mapData = MapDataModel()
    var fav = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()

        googleMapView.alpha = 0
        coordinateLabel.alpha = 0
        cityLabel.alpha = 0
        locationLabel.alpha = 0
        favButton.alpha = 0
        
        self.mapData.change(inUrl: temp)
        self.mapData.downloadData {
            self.updateMap()
            self.UpdateUI()
            SVProgressHUD.dismiss()
            
            UIView.animate(withDuration: 2, animations: {
                self.googleMapView.alpha = 1
                self.coordinateLabel.alpha = 1
                self.cityLabel.alpha = 1
                self.locationLabel.alpha = 1
                self.favButton.alpha = 1
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }

    func UpdateUI() {
        cityLabel.text = mapData.city + ", " + mapData.country
        locationLabel.text = mapData.location
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
        let check = locationLabel.text
        if let data = UserDefaults.standard.object(forKey: "FAV") as? [String]{
            if !data.contains(check!) {
                fav = data
                fav.append(check!)
                UserDefaults.standard.set(fav, forKey: "FAV")
            }
        }
        else {
            fav.append(check!)
            UserDefaults.standard.set(fav, forKey: "FAV")
        }

    }
    
    @IBAction func revButton(_ sender: Any) {
        nextTemp = "http://api.farells.com/JSON/wertu_review/" + locationLabel.text! + "/index.php"
        performSegue(withIdentifier: "reviewsSegue", sender: self)
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! ReviewsViewController
        print(nextTemp)
        next.temp = URL(string: nextTemp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }

}
