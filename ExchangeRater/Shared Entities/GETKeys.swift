//
//  GETKeys+Protocol.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

public struct GETPBCurrentKeys: CurrencyKeys {
    public static var baseCurrency: GETPBCurrentKeys = GETPBCurrentKeys(stringValue: "base_ccy")!
    
    public static var currency: GETPBCurrentKeys = GETPBCurrentKeys(stringValue: "ccy")!
    
    public static var saleRate: GETPBCurrentKeys = GETPBCurrentKeys(stringValue: "sale")!
    
    public static var buyRate: GETPBCurrentKeys = GETPBCurrentKeys(stringValue: "buy")!
    
    public let stringValue: String
    public var intValue: Int? { return nil }
    
    public init?(intValue: Int) { return nil }
    public init?(stringValue: String) { self.stringValue = stringValue }
}

public struct GETNBUCurrencyKeys: CurrencyKeys {
    public static var baseCurrency: GETNBUCurrencyKeys = GETNBUCurrencyKeys(stringValue: "baseCurrency")!
    
    public static var currency: GETNBUCurrencyKeys = GETNBUCurrencyKeys(stringValue: "currency")!
    
    public static var saleRate: GETNBUCurrencyKeys = GETNBUCurrencyKeys(stringValue: "saleRateNB")!
    
    public static var buyRate: GETNBUCurrencyKeys = GETNBUCurrencyKeys(stringValue: "purchaseRateNB")!
    
    public let stringValue: String
    public var intValue: Int? { return nil }
    
    public init?(intValue: Int) { return nil }
    public init?(stringValue: String) { self.stringValue = stringValue }
}
