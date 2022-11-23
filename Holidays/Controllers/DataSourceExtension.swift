//
//  DataSourceExtension.swift
//  Holidays
//
//  Created by Pedro Grando on 22/11/22.
//

import UIKit

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let months = Calendar.current.monthSymbols[section]
        
        let currentMonthList = self.holidaysDictionary[months]
        
        return currentMonthList?.count ?? 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Calendar.current.monthSymbols.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Calendar.current.monthSymbols[section]
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let months = Calendar.current.monthSymbols[indexPath.section]
        
        let currentMonthList = self.holidaysDictionary[months]
        
        let currentHoliday = currentMonthList?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.configCell(holiday: currentHoliday)
        
        return cell
    }
}
