 //
//  RatesService.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class RatesService: CurrentRatesProvider, DatedNBURatesProvider {
    var currentRatesURL: URL =  URL(string: "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5")!
    var NBURatesURL: URL =  URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=")!
    
    private let urlSession = URLSession.shared
    private let decoder = { () -> JSONDecoder in
        let dec = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dec.dateDecodingStrategy = .formatted(dateFormatter)
        return dec
    }()
   
    
    func fetchRates(complition: @escaping (Responce<[Currency<GETPBCurrentKeys>]>) -> ()) {
        urlSession.dataTask(with: currentRatesURL) { (data, responce, error) in
            guard error == nil else {
                complition(Responce.error(RespoceError.unknown))
                return
            }
            let currencies = try! self.decoder.decode([Currency<GETPBCurrentKeys>].self, from: data!)
            complition(Responce.success(currencies))
        }.resume()
    }
    
    func fetchRates(for date: Date, complition: @escaping (Responce<DatedCurrencyResponce<GETNBUCurrencyKeys>>) -> ()) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let url = URL(string: NBURatesURL.absoluteString + dateFormatter.string(from: date))! //ye, i know
        urlSession.dataTask(with: url) { (data, responce, error)  in
            guard error == nil else { fatalError() }
            let datedResp = try! self.decoder.decode(DatedCurrencyResponce<GETNBUCurrencyKeys>.self, from: data!)
            
            complition(Responce.success(datedResp))
        }.resume()
    }
    
}
