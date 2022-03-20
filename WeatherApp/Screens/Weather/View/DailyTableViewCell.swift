//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import UIKit
import Kingfisher

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!

    private var weatherModel: WeatherDataModel?
    static let identifier = "DailyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        weatherIcon.image = nil
    }
    
    func configure(model: WeatherDataModel) {
        self.weatherModel = model
    }
    
    func configureTableViewCellViewModelFor(_ index: Int) -> DailyTableViewCellViewModel {
        var dayLabelString: String?
        var weatherLabelString: String?
        var highTempLabelString: String?
        var lowTempLabelString: String?
        var humidityLabelString: String?
        var rainLabelString: String?
        var urlString: String?

        if let weatherModel =  weatherModel {
            let dailyModel = weatherModel.daily[index + 1]
            dayLabelString = Date(timeIntervalSince1970: Double(dailyModel.dt)).getDayForDate()
            weatherLabelString =  dailyModel.weather[0].main
            humidityLabelString = String(dailyModel.humidity) + "%"
            highTempLabelString = String(format: "%.1f", dailyModel.temp.max)
            lowTempLabelString = String(format: "%.1f", dailyModel.temp.min)
            
            if let rain = dailyModel.rain {
                rainLabelString = String(format: "%.1f", rain) + "%"
            }
            else {
                rainLabelString = "0%"
            }
        
            urlString = "http://openweathermap.org/img/wn/\(dailyModel.weather[0].icon)@2x.png"
        }
        return DailyTableViewCellViewModel(dayLabelString: dayLabelString,
                                           weatherLabelString: weatherLabelString,
                                           highTempLabelString: highTempLabelString,
                                           lowTempLabelString: lowTempLabelString,
                                           humidityLabelString: humidityLabelString,
                                           rainLabelString: rainLabelString,
                                           urlString: urlString)
    }

    func setupCell(_ viewModel: DailyTableViewCellViewModel) {
        dayLabel.text = viewModel.dayLabelString
        weatherLabel.text = viewModel.weatherLabelString?.firstCapitalized
        maxTempLabel.text = viewModel.highTempLabelString
        minTempLabel.text = viewModel.lowTempLabelString
        rainLabel.text = viewModel.rainLabelString
        humidityLabel.text = viewModel.humidityLabelString
        
        // iconURL is Valid URL
        
        if let iconURL = viewModel.urlString, iconURL != "", UIApplication.shared.canOpenURL(URL.init(string: iconURL) ?? URL.init(string: "")!)
        {
            let url = (URL(string: iconURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")!)
            
            weatherIcon?.kf.setImage(with: url)
            { result in
                
                // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
                
                switch result
                {
                case .success(let value):
                    
                    self.weatherIcon.image = value.image
                    
                case .failure(let error):
                    
                    self.weatherIcon.image = #imageLiteral(resourceName: "404-error-download")
                    
                    print(error) // The error happens
                }
            }
        }
        else
        {
            weatherIcon.image = #imageLiteral(resourceName: "404-error-download")
        }
    }
    
}

struct DailyTableViewCellViewModel {
    let dayLabelString: String?
    let weatherLabelString: String?
    let highTempLabelString: String?
    let lowTempLabelString: String?
    let humidityLabelString: String?
    let rainLabelString: String?
    let urlString: String?
}
