//
//  PBExchangeTableViewCell.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class PBExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sell: UILabel!
    
    
    func configure(currency: Currency<GETPBCurrentKeys>){
        name.text = currency.currency
        buy.text = String(currency.buy)
        sell.text = String(currency.sale)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
