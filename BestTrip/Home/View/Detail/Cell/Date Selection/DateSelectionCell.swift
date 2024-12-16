//
//  DateSelectionCell.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//

import UIKit
import HorizonCalendar

class DateSelectionCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCallendar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCalendar()
    }
    
    func createCalendar() {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: 2025, month: 4, day: 30))!
        
        let content = CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions())
        )
        
        let calendarView = CalendarView(initialContent: content)
        calendarView.daySelectionHandler = { day in
            let output = "Selected: \(day.components)"
            print(output)
        }
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        viewCallendar.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: viewCallendar.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: viewCallendar.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: viewCallendar.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: viewCallendar.bottomAnchor)
        ])
    }
}
