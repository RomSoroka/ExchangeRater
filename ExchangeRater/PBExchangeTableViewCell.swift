//
//  PBExchangeTableViewCell.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class PBExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!
    
    
    func configure(){
        guard let labels = stackView.arrangedSubviews as? [UILabel] else {
            fatalError()
        }
        labels[0].text = "EUR"
        labels[1].text = "28.300"
        labels[2].text = "28.300"
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
