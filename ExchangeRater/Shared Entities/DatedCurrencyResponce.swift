//
//  DatedCurrencyResponce.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class DatedCurrencyResponce<CurKeys: CurrencyKeys>: Decodable {
    var date = Date()
    var bank = "PB"
    var exchangeRate = [Currency<CurKeys>]()
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
        case date
        case bank
        case exchangeRate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        bank = try container.decode(String.self, forKey: .bank)
        exchangeRate = try container.decode([Currency<CurKeys>].self, forKey: .exchangeRate)
    }
}
