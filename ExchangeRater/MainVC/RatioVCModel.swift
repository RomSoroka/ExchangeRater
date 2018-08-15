//
//  RatioVCModel.swift
//  ExchangeRater
//
//  Created by Рома Сорока on 14.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

protocol CurrentRatesProvider {
    var currentRatesURL: URL { get set }
    func fetchRates(complition: @escaping (Responce<[Currency<GETPBCurrentKeys>]>) -> ())
}

protocol DatedNBURatesProvider {
    var NBURatesURL: URL { get set }
    func fetchRates(for: Date, complition: @escaping (Responce<DatedCurrencyResponce<GETNBUCurrencyKeys>>) -> ())
}

class RatioVCModel {
    var currentRates = [Currency<GETPBCurrentKeys>]()
    var datedRates = DatedCurrencyResponce<GETNBUCurrencyKeys>()
    
    let currentRatesProvider: CurrentRatesProvider
    let datedNBURatesProvider: DatedNBURatesProvider
    
    init(currentRatesProvider: CurrentRatesProvider, datedNBURatesProvider: DatedNBURatesProvider) {
        self.currentRatesProvider = currentRatesProvider
        self.datedNBURatesProvider = datedNBURatesProvider
    }
    
    func fetchCurrentRates(complition: @escaping () -> ()) {
        currentRatesProvider.fetchRates { (responce) in
            switch responce {
            case .success(let rates):
                self.currentRates = rates
            case .error(let err):
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                complition()
            }
        }
    }
    
    func fetchRates(for date: Date = .init(), complition: @escaping () -> ()) {
        datedNBURatesProvider.fetchRates(for: date) { (responce) in
            switch responce {
            case .success(let entity):
                self.datedRates = entity
            case .error(let err):
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                complition()                
            }
        }
    }
    
}
