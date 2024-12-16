//
//  PassengerCell.swift
//  BestTrip
//
//  Created by IREM SEVER on 11.12.2024.
//
import UIKit
protocol PassengerCellDelegate: AnyObject {
    func didUpdatePassengerCount(adults: Int, children: Int, infant: Int)
    func didConfirmPassenger()
}
class PassengerCell: UICollectionViewCell {
    @IBOutlet weak var buttonAdultMinus: UIButton!
    @IBOutlet weak var lblAdultCount: UILabel!
    @IBOutlet weak var buttonAdultPlus: UIButton!
    
    @IBOutlet weak var buttonChildrenMinus: UIButton!
    @IBOutlet weak var lblChildrenCount: UILabel!
    @IBOutlet weak var buttonChildrenPlus: UIButton!
    
    @IBOutlet weak var buttonInfantMinus: UIButton!
    @IBOutlet weak var lblInfantCount: UILabel!
    @IBOutlet weak var buttonInfantPlus: UIButton!
    
    @IBOutlet weak var buttonConfirmPassengers: UIButton!
    
    var delegate: PassengerCellDelegate?
    
    private var adultCount: Int = 1 {
        didSet {
            configure()
        }
    }
    private var childrenCount: Int = 0 {
        didSet {
            configure()
        }
    }
    private var infantCount: Int = 0 {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
 
    func configure() {
        lblAdultCount.text = "\(adultCount)"
        lblChildrenCount.text = "\(childrenCount)"
        lblInfantCount.text = "\(infantCount)"
        
        buttonAdultMinus.backgroundColor = adultCount > 1 ? .white : .lightGray
        buttonAdultMinus.layer.cornerRadius = 5

        buttonChildrenMinus.backgroundColor = childrenCount > 0 ? .white : .lightGray
        buttonChildrenMinus.layer.cornerRadius = 5

        buttonInfantMinus.backgroundColor = infantCount > 0 ? .white : .lightGray
        buttonInfantMinus.layer.cornerRadius = 5
        
        buttonAdultMinus.isEnabled = adultCount > 1
        buttonChildrenMinus.isEnabled = childrenCount > 0
        buttonInfantMinus.isEnabled = infantCount > 0
    }
    
    @IBAction func buttonAdultMinus(_ sender: Any) {
        if adultCount > 1 {
            adultCount -= 1
        }
    }
    
    @IBAction func buttonAdultPlus(_ sender: Any) {
        adultCount += 1
    }
    
    @IBAction func buttonChildrenMinus(_ sender: Any) {
        if childrenCount > 0 {
            childrenCount -= 1
        }
    }
    
    @IBAction func buttonChildrenPlus(_ sender: Any) {
        childrenCount += 1
    }
    
    @IBAction func buttonInfantMinus(_ sender: Any) {
        if infantCount > 0 {
            infantCount -= 1
        }
    }
    
    @IBAction func buttonInfantPlus(_ sender: Any) {
        infantCount += 1
    }
    
    @IBAction func buttonConfirmPassengers(_ sender: Any) {
        delegate?.didUpdatePassengerCount(adults: adultCount, children: childrenCount, infant: infantCount)
        delegate?.didConfirmPassenger()
    }
}
