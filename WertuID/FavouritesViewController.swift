//
//  FavouritesViewController.swift
//  WertuID
//
//  Created by Reavern on 5/3/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit
import SVProgressHUD

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fav = [String]()
    var temp: URL!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show()
        if let data = UserDefaults.standard.object(forKey: "FAV") as? [String] {
            fav = data as! [String]
            tableView.reloadData()
            
        }
        SVProgressHUD.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fav.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteCell
        cell.locationLabel.text = String(describing: fav[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        temp = URL(string: fav[indexPath.row])
        performSegue(withIdentifier: "favToMapSegue", sender: nil)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! MapViewController
        next.temp = temp
    }
    

}
