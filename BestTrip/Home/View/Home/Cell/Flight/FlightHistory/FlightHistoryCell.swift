//
//  FlightHistoryCell.swift
//  BestTrip
//
//  Created by İrem Sever on 6.12.2024.
//

import UIKit

class FlightHistoryCell: UICollectionViewCell {

    @IBOutlet weak var lblDepatureCity: UILabel!
    @IBOutlet weak var lblDepartureDate: UILabel!
    @IBOutlet weak var lblArrivalCity: UILabel!
    @IBOutlet weak var lblArrivalDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(with data: HomeData) {
        lblDepatureCity?.text = data.departureCity
        lblDepartureDate?.text = data.departureTime
        lblArrivalCity?.text = data.arrivalCity
        lblArrivalDate?.text = data.arrivalTime
    }
}

