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
        //let cal = UICalendarView()
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 12, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: 2025, month: 12, day: 30))!
        
        let content = CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
        
        let calendarView = CalendarView(initialContent: content)
        calendarView.daySelectionHandler = { day in
            let output = "selected:" + String(describing: day.components)
            print("output", output)
        }
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: viewCallendar.safeAreaLayoutGuide.topAnchor),
            calendarView.leftAnchor.constraint(equalTo: viewCallendar.safeAreaLayoutGuide.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: viewCallendar.safeAreaLayoutGuide.rightAnchor),
            calendarView.bottomAnchor.constraint(equalTo: viewCallendar.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
