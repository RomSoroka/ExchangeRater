//
//  ViewController.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class RatioViewController: UIViewController {
    @IBOutlet weak var currentRatesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentRatesTableView.rowHeight = currentRatesTableView.bounds.height / 3
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension RatioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == currentRatesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PBCell", for: indexPath) as! PBExchangeTableViewCell
            cell.configure()
            return cell
        } else {
            return UITableViewCell(frame: CGRect.null)
        }
    }
    
    
    
    
}
