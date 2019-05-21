//
//  WeatherapiTest.swift
//  UnitTesting DemoTests
//
//  Created by Soumil on 16/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//
import XCTest
import OHHTTPStubs
@testable import UnitTesting_Demo
class WeatherapiTest: DemoTestBaseClass {
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }    
    let viewModel = WeatherDetaViewModel()
    func testgetWeatherDetailsviaCityNameSuccess() {
        stub(condition: matcher, response: provider)
        let expect = XCTestExpectation.init(description: "Get Weather Details from city Name")
        promise = expect
        viewModel.delegate = self
        viewModel.getWeatherDetailsviaCityName(cityname: "London")
        wait(for: [expect], timeout: 10)
    }
    
    func testgetWeatherDetailsviaCoordinatesSuccess() {
        stub(condition: matcher, response: provider)
        let expect = XCTestExpectation.init(description: "Get Weather Details from Coordinates")
        promise = expect
        viewModel.delegate = self
        viewModel.getWeatherDetailsviaCoordinates(latitude: "22.5726", longitude: "88.3639")
        wait(for: [expect], timeout: 10)
    }
    
    func testgetWeatherDetailsviaZipCodeSuccess() {
        stub(condition: matcher, response: provider)
        let expect = XCTestExpectation.init(description: "Get Weather Details from Zip Code")
        promise = expect
        viewModel.delegate = self
        viewModel.getWeatherDetailsviaZipCode(zipCode: "94040,us")
        wait(for: [expect], timeout: 10)
    }
}

extension WeatherapiTest: ViewModelDelegate {
    func viewModelDidUpdate(sender: BaseViewModel) {
        if let viewModel = sender as? WeatherDetaViewModel {
            XCTAssertFalse((viewModel.model?.weather.isEmpty)!)
            promise?.fulfill()
        }
    }
    func viewModelUpdateFailed(error: WeatherAppError) {
        XCTFail(error.localizedMessage)
    }
}
