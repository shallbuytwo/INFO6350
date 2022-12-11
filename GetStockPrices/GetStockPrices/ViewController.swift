//
//  ViewController.swift
//  GetStockPrices
//
//  Created by wei wang on 10/12/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var indexSelected = 0
    var stockValues : [Company] = [Company]()
    let url = "https://us-central1-whatsapp-analytics-2de0e.cloudfunctions.net/app/allstocks"
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getStockPrice()
        // Do any additional setup after loading the view.
    }
    func getStockPrice () {
        AF.request(url).responseJSON { responseData in
            if responseData.error != nil {
                print(responseData.error!)
                return
            }
            self.stockValues = [Company]()
            let stockData = JSON(responseData.data as Any)

            for stock in stockData{
                let stockJSON = JSON(stock.1)
                let companyName = stockJSON["CompanyName"].stringValue
                let Price = stockJSON["Price"].stringValue
                let Symbol = stockJSON["Symbol"].stringValue
                self.stockValues.append(Company(companyName: companyName, symbol: Symbol, price: Price))
            }
            self.tblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str = "\(stockValues[indexPath.row].companyName) \(stockValues[indexPath.row].symbol) : \(stockValues[indexPath.row].price)"
        cell.textLabel?.text = str
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        // Send the symbol  to next VC
        performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetails" {
            let secondVC = segue.destination as! DetailsViewController
            let stock = stockValues[indexSelected]
            
            secondVC.companyName = stock.companyName
            secondVC.price = stock.price
            secondVC.symbol = stock.symbol
        }
    }


    
}
