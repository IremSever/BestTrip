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
    
    @IBOutlet weak var viewGradient: UIView!
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

    func configureDetail(with detailData: DetailData) {
        imgSlider.image = UIImage(named: detailData.image ?? "")
        lblPrice.text = detailData.title
        lblFaresFrom.text = detailData.detail
        heightLblPrice.constant = 30
        addGradient()
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.8).cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = viewGradient.bounds
        
        viewGradient.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        viewGradient.layer.insertSublayer(gradientLayer, at: 0)
    }
}
