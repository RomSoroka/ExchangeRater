//
//  NBUTableViewCell.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class NBUExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sellRate: UILabel!
    @IBOutlet weak var baseCurrencyRate: UILabel!
    
    func configure(currency: Currency<GETNBUCurrencyKeys>) {
        switch currency.currency {
        case "USD":
            name.text = "Доллар США"
        case "EUR":
            name.text = "Евро"
        default:
            name.text = currency.currency
        }
        sellRate.text = String(currency.sale) + currency.baseCurrency
        baseCurrencyRate.text = String(currency.buy) + currency.baseCurrency
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
