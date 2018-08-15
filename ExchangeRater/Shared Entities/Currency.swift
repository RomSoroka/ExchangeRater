//
//  Currency.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

public protocol CurrencyKeys: CodingKey {
    static var baseCurrency: Self { get }
    static var currency: Self { get }
    static var saleRate: Self { get }
    static var buyRate: Self { get }
}

struct Currency<Keys: CurrencyKeys>: Decodable {
    let baseCurrency: String
    let currency: String?
    let sale: Double
    let buy: Double
}

//MARK: Decoding
extension Currency {
    public enum CodingKeys: CodingKey {
        case baseCurrency
        case currency
        case sale
        case buy
        
        public var stringValue: String {
            switch self {
            case .baseCurrency: return Keys.baseCurrency.stringValue
            case .currency: return Keys.currency.stringValue
            case .sale: return Keys.saleRate.stringValue
            case .buy: return Keys.buyRate.stringValue
            }
        }
        
        public var intValue: Int? { return nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseCurrency = try container.decode(String.self, forKey: .baseCurrency)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
        
        if let value = try? container.decode(Double.self, forKey: .sale) {
            sale = value
        } else {
            sale = try Double(container.decode(String.self, forKey: .sale))!
        }
        
        if let value = try? container.decode(Double.self, forKey: .buy) {
            buy = value
        } else {
            buy = try Double(container.decode(String.self, forKey: .buy))!
        }
    }
    
}
