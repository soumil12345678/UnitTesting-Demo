//
//  Errors.swift
//  UnitTesting Demo
//
//  Created by Soumil on 17/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import Foundation
public protocol WeatherAppErrorCode {
    var code: Int {get}
    var domain: String {get}
    var localizedMessage: String {get}
    var localizedTitle: String? {get}
    
}

open class WeatherAppError: NSError {
    public var errorCode: WeatherAppErrorCode
    
    open var localizedMessage: String {
        return errorCode.localizedMessage
    }
    
    open var localizedTitle: String? {
        return errorCode.localizedTitle
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    public init(errorCode: WeatherAppErrorCode) {
        self.errorCode = errorCode
        super.init(domain: errorCode.domain, code: errorCode.code, userInfo: nil)
        
    }
    
}

class WeatherAppServiceError: WeatherAppError {
    
    enum ErrorCode: Int, WeatherAppErrorCode {
        
        case unknownError
        case connectionError
        case requestTimeOut
        case noNetwork
        
        var code: Int {
            return rawValue
        }
        var domain: String {
            return "WebService"
        }
        
        var localizedMessage: String {
            switch self {
            case .unknownError:
                return "Unknown error. Please try again later."
            case .connectionError:
                return "Could not connect to server. Please try again later."
            case .noNetwork:
                return "Not connected to internet. Please check your connection"
            case .requestTimeOut:
                return "Request Timed out"
            }
            
        }
        var localizedTitle: String? {
            return "WeatherAppGroup"
        }
        
    }
    
    static func customError(for error: NSError) -> ErrorCode {
        switch error.code {
        case -1009:
            return .noNetwork
        case -1001:
            return .requestTimeOut
        case -1008...(-1002):
            return .connectionError
        default:
            return .unknownError
        }
    }
    
    public convenience init(error: NSError) {
        let item = WeatherAppServiceError.customError(for: error)
        self.init(errorCode: item)
    }
}

class WeatherAppServerResponseError: WeatherAppError {
    
    static let JsonParsing = WeatherAppServerResponseError.init(errorCode: ErrorCode.jsonParsingError)
    static let Unknown = WeatherAppServerResponseError.init(errorCode: ErrorCode.unknownError)
    
    enum ErrorCode: WeatherAppErrorCode {
        
        case jsonParsingError
        case serverErrorMessage(String)
        case unknownError
        
        var code: Int {
            return 0
        }
        var domain: String {
            return "ServerResponse"
        }
        
        var localizedMessage: String {
            switch self {
            case .serverErrorMessage(let message):
                return message
            default:
                return "Internal error. Please try again later."
            }
            
        }
        var localizedTitle: String? {
            return "WeatherApp"
        }
        
    }
    
    public convenience init(error: String) {
        let item = ErrorCode.serverErrorMessage(error)
        self.init(errorCode: item)
    }
}
