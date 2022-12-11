//
//  DetailsViewController.swift
//  GetStockPrices
//
//  Created by wei wang on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSymbol: UILabel!
    var symbol = ""
    var companyName = ""
    var price = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName?.text = "Company Name: \(companyName)"
        lblPrice?.text = "Price: \(price)"
        lblSymbol?.text = "Symbol: \(symbol)"
        
        // Do any additional setup after loading the view.
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
