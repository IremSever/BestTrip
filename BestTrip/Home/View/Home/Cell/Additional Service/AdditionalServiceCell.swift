//
//  AdditionalServiceCell.swift
//  BestTrip
//
//  Created by İrem Sever on 9.12.2024.
//

import UIKit

protocol AdditionalServiceCellDelegate: AnyObject {
    func additionalServiceCellDidRequestShowDetail(_ cell: AdditionalServiceCell, detailType: DetailType)
}

class AdditionalServiceCell: UICollectionViewCell, ConfigurableCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var buttonDetail: UIButton!
    weak var delegate: AdditionalServiceCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with data: HomeData) {
        viewBg.layer.cornerRadius = 10
        viewBg.layer.masksToBounds = true
        imgIcon.image = UIImage(named: data.image ?? "")
        lblTitle.text = data.title
        lblDetail.text = data.detail
    }
  
    @IBAction func buttonDetail(_ sender: Any) {
        delegate?.additionalServiceCellDidRequestShowDetail(self, detailType: .additionalServiceList)
    }
}
