//
//  SliderCell.swift
//  BestTrip
//
//  Created by İrem Sever on 6.12.2024.
//
import UIKit

class CampaignCell: UICollectionViewCell, ConfigurableCell {

    @IBOutlet weak var heightLblPrice: NSLayoutConstraint!
    @IBOutlet weak var lblFaresFrom: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgSlider: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(with data: HomeData) {
        imgSlider.image = UIImage(named: data.image ?? "")
        lblTitle?.text = data.title
        lblPrice?.text = data.price
        if let title = lblPrice.text, !title.isEmpty {
            lblFaresFrom.text = "Fares From"
            imgSlider.layer.cornerRadius = 10
            imgSlider.layer.masksToBounds = true
        }

    }
    //burada
    func configureDetail(with detailData: DetailData) {
        imgSlider.image = UIImage(named: detailData.image ?? "")
        lblPrice.text = detailData.title
        lblFaresFrom.text = detailData.detail
        heightLblPrice.constant = 30
    }
    
}
