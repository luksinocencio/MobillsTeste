//
//  FormatarDinheiro.swift
//  MobillsTeste
//
//  Created by Lucas Inocencio on 24/05/21.
//

import Foundation

class FormatarDinheiro {
    static let shared = FormatarDinheiro()
    
    let formatter = NumberFormatter()
    
    func getFormattedValue(of value: Double, withCurrency currency: String) -> String {
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency
        formatter.alwaysShowsDecimalSeparator = true
        formatter.locale = NSLocale(localeIdentifier: "pt_BR") as Locale
        
        return formatter.string(for: value)!
    }
    
}
