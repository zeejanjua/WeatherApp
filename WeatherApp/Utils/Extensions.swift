//
//  Extensions.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import Foundation

extension Date {
    
    func getDayForDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
}


extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
