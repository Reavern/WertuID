//
//  ReviewsViewController.swift
//  WertuID
//
//  Created by Reavern on 5/13/17.
//  Copyright © 2017 Reavern. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var temp: URL!
    var display: [String] = []
    var reviews = ReviewDataModel()
    
    @IBOutlet weak var webService: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(temp)
        //reviews.change(inUrl: temp)
        reviews.downloadData {
            self.display = self.reviews.chat
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func sendButton(_ sender: Any) {
        let web = URL(string: "http://api.farells.com/JSON/wertu_add/" + commentText.text! + "/index.php")!
        let webreq = URLRequest(url: web)
        webService.loadRequest(webreq)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return display.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatCell
        cell.chatLabel.text = display[indexPath.row]
        return cell
    }
    

}
