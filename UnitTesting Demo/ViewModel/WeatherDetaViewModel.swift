//
//  WeatherDetaViewModel.swift
//  UnitTesting Demo
//
//  Created by Soumil on 16/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import Foundation
class WeatherDetaViewModel: BaseViewModel {
    let dataManager = WeatherDataManager.shared
    var model: WeatherData? {
        didSet {
            delegate?.viewModelDidUpdate(sender: self)
        }
    }
    
    func getWeatherDetailsviaCoordinates(latitude: String, longitude: String) {
        dataManager.getWeatherDetailsviaCoordinates(latitude: latitude, longitude: longitude, success: { (data) in
            let decoder = JSONDecoder()
            do {
                let item = try decoder.decode(WeatherData.self, from: data)
                self.model = item
            } catch {
                self.delegate?.viewModelUpdateFailed(error: WeatherAppServerResponseError.JsonParsing)
                print(error)
            }
        }, failure: { (error) in
            self.delegate?.viewModelUpdateFailed(error: error)
            print(error)
        })
    }
    
    func getWeatherDetailsviaCityName(cityname: String) {
        dataManager.getWeatherDetailsviaCityName(cityname: cityname, success: { (data) in
            let decoder = JSONDecoder()
            do {
                let item = try decoder.decode(WeatherData.self, from: data)
                self.model = item
            } catch {
                self.delegate?.viewModelUpdateFailed(error: WeatherAppServerResponseError.JsonParsing)
                print(error)
            }
        }, failure: { (error) in
            self.delegate?.viewModelUpdateFailed(error: error)
            print(error)
        })
    }
    
    func getWeatherDetailsviaZipCode(zipCode: String) {
        dataManager.getWeatherDetailsviaZipCode(zipCode: zipCode, success: { (data) in
            let decoder = JSONDecoder()
            do {
                let item = try decoder.decode(WeatherData.self, from: data)
                self.model = item
            } catch {
                self.delegate?.viewModelUpdateFailed(error: WeatherAppServerResponseError.JsonParsing)
                print(error)
            }
        }, failure: { (error) in
            self.delegate?.viewModelUpdateFailed(error: error)
            print(error)
        })
    }
}
