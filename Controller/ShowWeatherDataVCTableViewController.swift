//
//  ShowWeatherDataVCTableViewController.swift
//  UnitTesting Demo
//
//  Created by Soumil on 17/05/19.
//  Copyright © 2019 LPTP233. All rights reserved.
//

import UIKit

class ShowWeatherDataVCTableViewController: UITableViewController {

    let viewmodel = WeatherDetaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.delegate = self
        if butttonTag == 1 {
        viewmodel.getWeatherDetailsviaCityName(cityname: "London")
        }else if butttonTag == 2 {
        viewmodel.getWeatherDetailsviaCoordinates(latitude: "22.5726", longitude: "88.3639")
        }else {
        viewmodel.getWeatherDetailsviaZipCode(zipCode: "94040,us")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! Customcell
        switch indexPath.row {
        case 0:
            cell.namelbl.text = "City Name"
            cell.datalbl.text = viewmodel.model?.name ?? "N/A"
        case 1:
             cell.namelbl.text = "Humidity"
             cell.datalbl.text = String(viewmodel.model?.main.humidity ?? 0)+"%"
        case 2:
            cell.namelbl.text = "Temperature"
            if let temp = viewmodel.model?.main.temp {
                cell.datalbl.text = String(Float(temp - 273))+"°C"
            }else {
                cell.datalbl.text = "N/A"
            }
        case 3:
            cell.namelbl.text = "Wind Speed"
            cell.datalbl.text = "\(viewmodel.model?.wind?.speed ?? 0)Km/h"
        default:
            break
        }
        return cell
    }

}

extension ShowWeatherDataVCTableViewController : ViewModelDelegate {
    func viewModelDidUpdate(sender: BaseViewModel) {
           tableView.reloadData()
    }
    func viewModelUpdateFailed(error: WeatherAppError) {
        print((error.localizedMessage))
    }
}
