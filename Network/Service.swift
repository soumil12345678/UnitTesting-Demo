//
//  SerVices.swift
//  UnitTesting Demo
//
//  Created by Soumil on 17/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import Alamofire

struct APIConstants {
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static let contentType = "application/json"
    static let headers: [String: String] = ["Content-Type": contentType]
    static let appKey = "appid"
    static let appKeyValue = "53a6438dc6f778ac50614cfa0f9609c4"
}

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

public class APIRouter: APIConfiguration {
    
    let method: HTTPMethod = .get
    var path: String {
        return ""
    }
    
    var parameters: Parameters?
    
    init(_ params: Parameters? = nil ) {
        if var item = params {
            item[APIConstants.appKey] = APIConstants.appKeyValue
            parameters = item
        } else {
            parameters = [APIConstants.appKey: APIConstants.appKeyValue]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.queryString.encode(request, with: parameters)
    }
}

class WeatherAppService: NSObject {
    
    static func request(_ request: URLRequestConvertible, success:@escaping (Data) -> Void, failure:@escaping (WeatherAppError) -> Void) {
        #if DEBUG
        let sample = try? request.asURLRequest()
        print("Response for \(String(describing: sample?.url))")
        if let test = sample?.httpBody, let params = String.init(data: test, encoding: .utf8) {
            print("Params \(params)")
        }
        #endif
        Alamofire.request(request).responseData { (responseObject) -> Void in
            if let data = responseObject.data, responseObject.result.isSuccess {
                #if DEBUG
                let json = String(decoding: data, as: UTF8.self)
                print(json.debugDescription)
                #endif
                success(data)
            }
            if responseObject.result.isFailure {
                var item: WeatherAppError
                if let error = responseObject.result.error as NSError? {
                    //Known error.
                    item = WeatherAppServiceError.init(error: error)
                } else {
                    //Other failures
                    item = WeatherAppServiceError.init(errorCode: WeatherAppServiceError.ErrorCode.unknownError)
                }
                failure(item)
            }
        }
    }
}
