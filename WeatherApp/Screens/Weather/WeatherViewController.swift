//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 18/03/2022.
//

import UIKit
import MBProgressHUD
import NotificationBannerSwift

class WeatherViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    var viewModel: WeatherViewModel?
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel?.delegate = self
        viewModel?.fetchWeatherData()
    }
    
    // MARK: - Setups
    private func setupUI() {
        contentView.isHidden = true
        emptyView.isHidden = true
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Button Actions
    @IBAction func didTapRefreshButton() {
        viewModel?.fetchWeatherData()
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
        if let weatherModel = viewModel?.dataSource {
            cell.configure(model: weatherModel)
        }
        let viewModel = cell.configureTableViewCellViewModelFor(indexPath.row)
        cell.setupCell(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView.isTracking { return }
        
        cell.contentView.alpha = 0.3
        cell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        
        // Simple Animation
        UIView.animate(withDuration: 0.3) {
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.661237454, blue: 1, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect.init(x: 13.0, y: 10, width: tableView.frame.width - 11, height: 35)
        view.addSubview(titleLabel)
        
        titleLabel.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        titleLabel.text = "Forecast of upcoming 7 days"
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
}

// MARK: - WeatherViewModelDelegate
extension WeatherViewController: WeatherViewModelDelegate {
    func didLoadWeatherData() {
        guard let weather = viewModel?.dataSource, let currentWeather = weather.current.weather.first,
              let dailytWeather = weather.daily.first else { return }
        
        contentView.isHidden = false
        emptyView.isHidden = true
        
        weatherLabel.text =  currentWeather.main.firstCapitalized
        currentTempLabel.text = String(format: "%.1f",  weather.current.temp) + "°C"
        minTempLabel.text = String(format: "%.1f", dailytWeather.temp.min) + "°C"
        maxTempLabel.text = String(format: "%.1f", dailytWeather.temp.max) + "°C"
        humidityLabel.text = "\(weather.current.humidity)%"
        feelsLikeLabel.text = String(format: "%.1f", weather.current.feelsLike) + "°C"
        
        let iconURL = "http://openweathermap.org/img/wn/\(currentWeather.icon)@2x.png"
        let url = (URL(string: iconURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")!)
        
        weatherIcon?.kf.setImage(with: url)
        { result in
                        
            switch result
            {
            case .success(let value):
                
                self.weatherIcon.image = value.image
                
            case .failure(let _):
                
                self.weatherIcon.image = #imageLiteral(resourceName: "404-error-download")
            }
        }
        
        tableView.reloadData()
    }
    
    func showEmptyView(message:String) {
        contentView.isHidden = true
        emptyView.isHidden = false
        errorMessageLabel.text = message
    }
    
    func showLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
