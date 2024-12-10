//
//  AdditionalServiceCell.swift
//  BestTrip
//
//  Created by İrem Sever on 9.12.2024.
//

import UIKit

class AdditionalServiceCell: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with data: HomeData) {
        viewBg.layer.cornerRadius = 10
        viewBg.layer.masksToBounds = true
        imgIcon.image = UIImage(named: data.image ?? "")
        lblTitle.text = data.title
        lblDetail.text = data.detail
        
    }
    
}
