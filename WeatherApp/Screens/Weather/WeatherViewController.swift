//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Zeeshan Tariq on 18/03/2022.
//

import UIKit

class WeatherViewController: BaseController {
    
    //MARK: - Properties
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: WeatherViewModel?
    
    //MARK: - ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.getLocation()
        setupTableView()
    }
    
    // MARK: - Setups
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
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
    
}

// MARK: - WeatherViewModelDelegate

extension WeatherViewController: WeatherViewModelDelegate {
    func didLoadWeatherData() {
        
    }
    
    func showEmptyView(message: String) {
        
    }
    
    
}
