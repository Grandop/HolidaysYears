//
//  ViewController.swift
//  Holidays
//
//  Created by Pedro Grando on 22/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var holiday: [Holidays] = []
    
    var holidaysDictionary: [String: [Holidays]] = [:]
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentYear: UILabel!
    @IBOutlet weak var popUpButtonYear: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        setPopUpbutton()
        getApi(year: currentYear.text ?? "")
    
    }
    
    func hideLoading() {
        self.loaderView.isHidden = true
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
    func showLoading() {
        self.loaderView.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.loaderView.layer.borderWidth = 1
        self.loaderView.layer.cornerRadius = 8
    }
    
    func setPopUpbutton(){
        let optionClosure = {(action : UIAction) in
            self.currentYear.text = action.title
            self.getApi(year: action.title)
        }
        
        var yearsArray = [UIAction]()
                
        for year in 1999...2100 {
            
//            if year != 2004 {
                let action = UIAction(title: String(year), state: .off, handler: optionClosure)
                yearsArray.append(action)
//            }
        
        
        }
        
        yearsArray[0].state = .on
        let optionsMenu = UIMenu(title: "Anos", options: .displayInline, children: yearsArray)
        
        popUpButtonYear.menu = optionsMenu
        popUpButtonYear.showsMenuAsPrimaryAction = true
        popUpButtonYear.changesSelectionAsPrimaryAction = true
        
    }
        
    func getApi(year: String) {
        let url = URL(string: "https://brasilapi.com.br/api/feriados/v1/\(year)")
        
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if let data = data, error == nil {
                    do {
                        let dateFormat = DateFormatter()
                        dateFormat.dateFormat = "yyyy-MM-dd"
                        
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(dateFormat)
                        
                        let holidays = try decoder.decode([Holidays].self, from: data)
                        
                        self.holiday = holidays
                        
                        self.holidaysDictionary = Dictionary(grouping: holidays, by: { holiday in
                            holiday.getMonthName()
                        })
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.hideLoading()
                        }
                        
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            showLoading()
            task.resume()
        }
    }
}

