//
//  ListViewController.swift
//  WertuID
//
//  Created by Reavern on 3/18/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var list = ListDataModel(inURL: "")
    var country = [String]()
    var city = [String]()
    var location = [String]()
    var latitude = [String]()
    var longitude = [String]()
    var cityCount = [String]()
    var count = [String]()
    var tempCount = 0
    var temp = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempCount = 0
        list.downloadData {
            self.setData()
            self.list.countData {
                self.setCount()
                self.collectionView.reloadData()
            }
        }
    }


    
    func setData() {
        self.country = list.country
        self.city = list.city
        self.location = list.location
        self.latitude = list.latitude
        self.longitude = list.longitude
    }
    
    func setCount() {
        self.cityCount = list.cityCount
        self.count = list.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cityCount.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(count[section])!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ListHeader
        sectionHeader.headLabel.text = cityCount[indexPath.section]
        
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListCell
         
        if indexPath.section != 0 {
            tempCount = 0
            for number in 0...indexPath.section - 1 {
                tempCount = tempCount + Int(count[number])!
            }
            
        }

        cell.locationLabel.text = location[indexPath.row + tempCount]
        cell.coordinateLabel.text = latitude[indexPath.row + tempCount] + ", " + longitude[indexPath.row + tempCount]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            tempCount = 0
            for number in 0...indexPath.section - 1 {
                tempCount = tempCount + Int(count[number])!
            }
            
        }
        
        temp = "http://reavern.esy.es/JSON/wertu_map/" + location[indexPath.row + tempCount] + "/index.php"
        performSegue(withIdentifier: "mapSegue", sender: self)

    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let map = segue.destination as? MapViewController
        map?.temp = URL(string: temp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
}
