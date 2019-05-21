//
//  DemoTestBaseClass.swift
//  UnitTesting DemoTests
//
//  Created by Soumil on 16/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import UnitTesting_Demo

class DemoTestBaseClass: XCTestCase {
    
    var promise: XCTestExpectation?

    override func setUp() {
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }
    
    func matcher(request: URLRequest) -> Bool {
        if ProcessInfo.processInfo.environment["Mock-API"] == "true" {
            return request.url?.host == "api.openweathermap.org"
        }
        return false
    }
    
    func provider(request: URLRequest) -> OHHTTPStubsResponse {
        // Stub it with your stub file (which is in same bundle as self)
        let fileName = "sample.json"
        let stubPath = OHPathForFile(fileName, type(of: self))
        return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
    }    
}
