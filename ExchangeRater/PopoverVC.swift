//
//  PopoverVC.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 15.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class PopoverVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    var chosenDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(chosenDate, animated: false)
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        chosenDate = datePicker.date
        let dest = popoverPresentationController?.delegate as! RatioViewController
        dest.chosenDate = chosenDate
    }
}
