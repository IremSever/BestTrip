//
//  CitiesCell.swift
//  BestTrip
//
//  Created by İrem Sever on 15.12.2024.
//

import UIKit

class CitiesCell: UICollectionViewCell{
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: HomeData) {
        lblCity.text = data.city
        lblCountry.text = data.country
    }
}
