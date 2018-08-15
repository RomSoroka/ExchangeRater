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
    @IBOutlet weak var NBURatesTableView: UITableView!
    @IBOutlet weak var calendar: UIButton! {
        didSet {
            calendar.imageView?.contentMode = .scaleAspectFit
            calendar.imageView?.highlightedImage = #imageLiteral(resourceName: "calendarGreen")
        }
    }
    @IBOutlet weak var topSpinner: UIActivityIndicatorView!
    @IBOutlet weak var botSpinner: UIActivityIndicatorView!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var NBUDateLabel: UILabel!
    lazy private var dateFormater = { () -> DateFormatter in
        let dForm = DateFormatter()
        dForm.dateFormat = "dd.MM.yyyy"
        return dForm
    }
    var chosenDate = Date() {
        didSet {
            botSpinner.startAnimating()
            NBUDateLabel.text = dateFormater().string(from: chosenDate)
            model.datedRates.exchangeRate.removeAll()
            NBURatesTableView.reloadData()
            model.fetchRates(for: chosenDate) {
                self.NBURatesTableView.reloadData()
                self.botSpinner.stopAnimating()
            }
        }
    }
    var selectedPBIndex: IndexPath? {
        willSet {
            
            if let newIndex = newValue,
                selectedPBIndex != newValue,
                let selectedRow = model.datedRates.exchangeRate
                    .index(where: { (curr) -> Bool in
                        let selectedCurrency = self.model.currentRates[newIndex.row].currency
                        return curr.currency == selectedCurrency
                    }) {
                selectedNBUIndex = nil
                let selectedIndex = IndexPath(item: selectedRow, section: 0)
                NBURatesTableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .middle)
                
            }
        }
    }
    
    var selectedNBUIndex: IndexPath? {
        willSet {
            

            if let newIndex = newValue,
                selectedNBUIndex != newValue,
                let selectedRow = model.currentRates
                    .index(where: { (curr) -> Bool in
                        let selectedCurrency = self.model.datedRates.exchangeRate[newIndex.row].currency
                        return curr.currency == selectedCurrency
                }) {
                selectedPBIndex = nil
                let selectedIndex = IndexPath(item: selectedRow, section: 0)
                currentRatesTableView.selectRow(at: selectedIndex, animated: true, scrollPosition: .middle)
                
            }
        }
    }
    
    
    let model = { () -> RatioVCModel in 
        let ratesService = RatesService()
        return RatioVCModel(currentRatesProvider: ratesService, datedNBURatesProvider: ratesService)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        NBUDateLabel.text = dateFormater().string(from: chosenDate)
        currentDateLabel.text = dateFormater().string(from: chosenDate)
        
        model.fetchCurrentRates {
            self.currentRatesTableView.reloadData()
            self.topSpinner.stopAnimating()
        }
        model.fetchRates {
            self.NBURatesTableView.reloadData()
            self.botSpinner.stopAnimating()
        }
    }
    
}

extension RatioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == currentRatesTableView {
            return model.currentRates.count
        } else {
            return model.datedRates.exchangeRate.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3046919771, green: 0.5547536264, blue: 0.6196078431, alpha: 1)
        if tableView == currentRatesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PBCell", for: indexPath) as! PBExchangeTableViewCell
            cell.configure(currency: model.currentRates[indexPath.row])
            
            cell.selectedBackgroundView = view

            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NBUCell", for: indexPath) as! NBUExchangeTableViewCell
            
            let currency = model.datedRates.exchangeRate[indexPath.row]
            cell.configure(currency: currency)
            
            
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = #colorLiteral(red: 0.4623708013, green: 0.582409239, blue: 0.5360671137, alpha: 1)
            } else {
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            
            cell.selectedBackgroundView = view
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let previoslySelectedRow = NBURatesTableView.indexPathForSelectedRow {
            NBURatesTableView.deselectRow(at: previoslySelectedRow, animated: true)
        }
        if let previoslySelectedRow = currentRatesTableView.indexPathForSelectedRow {
            currentRatesTableView.deselectRow(at: previoslySelectedRow, animated: true)
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == currentRatesTableView {
            selectedPBIndex = indexPath
        } else {
            selectedNBUIndex = indexPath
        }
    }
    
    
}

extension RatioViewController: UIPopoverPresentationControllerDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverID" {
            let popoverViewController = segue.destination as! PopoverVC
            popoverViewController.chosenDate = chosenDate
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController!.delegate = self

        }
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
