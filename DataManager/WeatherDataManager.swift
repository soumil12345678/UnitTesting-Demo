//
//  WeatherDataManager.swift
//  UnitTesting Demo
//
//  Created by Soumil on 16/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import Foundation

enum WeatherRoute: String {
    case endUrl = "weather"
}

public class WeatherRouter: APIRouter {
    
    let weatherRoute: WeatherRoute
    
    init(_ params: [String: Any]? = nil, route: WeatherRoute) {
        weatherRoute = route
        super.init(params)
    }
    
    override var path: String {
        return weatherRoute.rawValue
    }
}

class WeatherDataManager: NSObject {
    
    static let shared = WeatherDataManager()
    
    private override init() {
        
    }
    
    public func getWeatherDetailsviaCoordinates(latitude: String, longitude: String, success:@escaping (Data) -> Void, failure:@escaping (WeatherAppError) -> Void) {
        let params = ["lat": latitude, "lon": longitude]
        let router = WeatherRouter(params, route: .endUrl)
        WeatherAppService.request(router, success: success, failure: failure)
    }
    
    public func getWeatherDetailsviaCityName(cityname: String, success:@escaping (Data) -> Void, failure:@escaping (WeatherAppError) -> Void) {
        let params = ["q": cityname]
        let router = WeatherRouter(params, route: .endUrl)
        WeatherAppService.request(router, success: success, failure: failure)
    }
    
    public func getWeatherDetailsviaZipCode(zipCode: String, success:@escaping (Data) -> Void, failure:@escaping (WeatherAppError) -> Void) {
        let params = ["zip": zipCode]
        let router = WeatherRouter(params, route: .endUrl)
        WeatherAppService.request(router, success: success, failure: failure)
    }
}
