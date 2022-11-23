//
//  CustomCell.swift
//  Holidays
//
//  Created by Pedro Grando on 22/11/22.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var holidayName: UILabel!
    @IBOutlet weak var monthDayView: UIView!
    @IBOutlet weak var monthDayNumber: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthDayView.layer.cornerRadius = 8
    }
    
    func configCell(holiday: Holidays?) {

        monthDayNumber.text = holiday?.getDayOfMonth()
        weekDay.text = holiday?.getDayOfWeek()
        holidayName.text = holiday?.name
}
    

    
}
