//
//  FlightCell.swift
//  BestTrip
//
//  Created by İrem Sever on 6.12.2024.
//

import UIKit

protocol FlightCellDelegate: AnyObject {
    func flightCellDidRequestShowDetail(_ cell: FlightCell, detailType: DetailType)
}

class FlightCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UpdateCityCellDelegate, PassengerCellDelegate, ConfigurableCell {
   
    weak var delegate: FlightCellDelegate?
    @IBOutlet weak var collectionViewHistory: UICollectionView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    var viewModel = HomeViewModel()
    
    @IBOutlet weak var viewBgFlight: UIView!
    @IBOutlet weak var viewBgInfo: UIView!
    @IBOutlet weak var viewSeperator: UIView!
    
    @IBOutlet weak var lblCityFrom: UILabel!
    @IBOutlet weak var lblFromAirport: UILabel!
    @IBOutlet weak var lblCityTo: UILabel!
    @IBOutlet weak var lblToAirport: UILabel!
    
    @IBOutlet weak var lblDepartureDate: UILabel!
    
    @IBOutlet weak var lblTitleDepartureDate: UILabel!
    @IBOutlet weak var lblReturnDate: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    @IBOutlet weak var lblPassenger: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        loadData()
        segmentedControl.selectedSegmentIndex = 0
        segmentValueChanged(segmentedControl)
        
    }
    
    func configure(with data: HomeData) {
        heightCollectionView.constant = 0
        
        let flightPath = UIBezierPath(roundedRect: viewBgFlight.bounds,
                                      byRoundingCorners: [.topLeft, .topRight],
                                      cornerRadii: CGSize(width: 20, height: 20))
        let flightMask = CAShapeLayer()
        flightMask.path = flightPath.cgPath
        viewBgFlight.layer.mask = flightMask
        
        let infoPath = UIBezierPath(roundedRect: viewBgInfo.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: 20, height: 20))
        let infoMask = CAShapeLayer()
        infoMask.path = infoPath.cgPath
        viewBgInfo.layer.mask = infoMask
        
        lblFromAirport.text = data.departureAirportCode
        
        lblToAirport.text = data.arrivalAirportCode
        didUpdateCity(from: lblCityFrom.text ?? "", to: lblCityTo.text ?? "")
        segmentedControl.layer.cornerRadius = 20
        segmentedControl.layer.masksToBounds = true
        
    }
    
    
    func didUpdatePassengerCount(adults: Int, children: Int, infant: Int) {
        var passengerText = ""
        
        if adults > 0 {
            passengerText += "Adult(s): \(adults) "
        }
        if children > 0 {
            passengerText += "Child(ren): \(children) "
        }
        if infant > 0 {
            passengerText += "Infant(s): \(infant)"
        }
        
        lblPassenger.text = passengerText
    }
    func didConfirmPassenger() {
        print("confirmed")
    }
    
    func didUpdateCity(from: String, to: String) {
        lblCityFrom.text = from
        lblCityTo.text = to
    }
    
}

//buttons
extension FlightCell {
    @IBAction func buttonChange(_ sender: Any) {
        print("change")
    }
    
    @IBAction func buttonCalendar(_ sender: Any) {
        delegate?.flightCellDidRequestShowDetail(self, detailType: .dateSelection)
    }
    
    @IBAction func buttonSearch(_ sender: Any) {
        print("search")
    }
    
    @IBAction func buttonSelectAirport(_ sender: Any) {
        delegate?.flightCellDidRequestShowDetail(self, detailType: .citySelection)
    }
    
    @IBAction func buttonSelectDate(_ sender: Any) {
        delegate?.flightCellDidRequestShowDetail(self, detailType: .dateSelection)
    }
    
    @IBAction func buttonSelectPassenger(_ sender: Any) {
        delegate?.flightCellDidRequestShowDetail(self, detailType: .passengerSelection)
    }
}

//segmented contorller
extension FlightCell {
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            lblTitleDepartureDate.text = "Return Date"
            lblReturnDate.text = "12.12.24"
        case 1:
            lblTitleDepartureDate.text = ""
            lblReturnDate.text = "One-way"
        default:
            break
        }
        
    }
}

//history collection view
extension FlightCell {
    func setupCollectionView() {
        collectionViewHistory.delegate = self
        collectionViewHistory.dataSource = self
        collectionViewHistory.showsHorizontalScrollIndicator = false
        registerCell()
    }
    
    func registerCell(){
        collectionViewHistory.register(FlightHistoryCell.self, forCellWithReuseIdentifier: "FlightHistoryCell")
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionViewHistory?.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightHistoryCell", for: indexPath) as! FlightHistoryCell
        return cell
    }
}

