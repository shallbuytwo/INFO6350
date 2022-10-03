//
//  ViewController.swift
//  Tourist App
//
//  Created by wei wang on 10/2/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let touristPlaceNames = ["Lake", "Temple", "Flower"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return touristPlaceNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TouristCell", owner: self)?.first as! TouristCell
        cell.imgTourist.image = UIImage(named: touristPlaceNames[indexPath.row])
        cell.lblTourist.text = touristPlaceNames[indexPath.row]
        return cell
    }
    
}

