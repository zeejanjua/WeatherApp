//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!

    static let identifier = "DailyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
