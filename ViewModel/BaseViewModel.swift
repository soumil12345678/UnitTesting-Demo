//
//  BaseViewModel.swift
//  UnitTesting Demo
//
//  Created by Soumil on 17/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func viewModelDidUpdate(sender: BaseViewModel)
    func viewModelUpdateFailed(error: WeatherAppError)
}

class BaseViewModel: NSObject {    
    var delegate: ViewModelDelegate?
}
