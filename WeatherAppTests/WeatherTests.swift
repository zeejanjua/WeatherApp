//
//  WeatherTests.swift
//  WeatherAppTests
//
//  Created by Zeeshan Tariq on 20/03/2022.
//

import XCTest
@testable import WeatherApp

class WeatherTests: XCTestCase {
    
    var controller: WeatherViewController?
    
    override func setUp() {
        super.setUp()
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = mainStoryBoard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
        _ = controller?.view
    }
    
    override func tearDown() {
        controller = nil
        super.tearDown()
    }
    
    func testOutletBinding() {
        
        XCTAssertNotNil(controller?.contentView, "Connect contentView outlet")
        XCTAssertNotNil(controller?.emptyView, "Connect emptyView outlet")
        XCTAssertNotNil(controller?.weatherIcon, "Connect weatherIcon outlet")
        XCTAssertNotNil(controller?.currentTempLabel, "Connect currentTempLabel outlet")
        XCTAssertNotNil(controller?.humidityLabel, "Connect humidityLabel outlet")
        XCTAssertNotNil(controller?.tableView, "Connect tableView outlet")
        
        if let tableView = controller?.tableView {
            XCTAssertNotNil(tableView.delegate as? WeatherViewController, "TableView delegate not assigned")
            XCTAssertNotNil(tableView.dataSource as? WeatherViewController, "TableView dataSource not assigned")
        }
    }
    
    func testWeatherInfoAPI() {
        let expect = expectation(description: "Weather Info API response")
        
        let successBlock:DefaultAPISuccessClosure! = { response in
            XCTAssertNotNil(response, "Should always recieved some data in response");
            expect.fulfill()
        }
        let failureBlock:DefaultAPIFailureClosure = { error in
            XCTAssertNotNil(error, "Request failed with error : \(String(describing: error.localizedDescription))")
            expect.fulfill()
        }
        
        WeatherAPIHandler.shared.fetchWeatherData(latitude: 31.3453434, longitude: 14.29234932, success: successBlock, failure: failureBlock)
        
        waitForExpectations(timeout: TimeInterval(120)){ error in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
    }
    
}
