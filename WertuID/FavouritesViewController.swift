//
//  FavouritesViewController.swift
//  WertuID
//
//  Created by Reavern on 5/3/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit
import SVProgressHUD

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{

    var fav = [String]()
    var filteredData = [String]()
    var temp = ""
    
    var searchController: UISearchController!
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    override func viewDidAppear(_ animated: Bool) {

        SVProgressHUD.show()
        if let data = UserDefaults.standard.object(forKey: "FAV") as? [String] {
            fav = data
            filteredData = fav
            tableView.reloadData()
        }
        SVProgressHUD.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteCell
        cell.locationLabel.text = filteredData[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        temp = "http://api.farells.com/JSON/wertu_map/" + filteredData[indexPath.row] + "/index.php"
        performSegue(withIdentifier: "favToMapSegue", sender: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? fav : fav.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! MapViewController
        next.temp = URL(string: temp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
    

}
