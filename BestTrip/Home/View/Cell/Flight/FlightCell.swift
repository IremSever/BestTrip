//
//  FlightCell.swift
//  BestTrip
//
//  Created by İrem Sever on 6.12.2024.
//
//segmentedcontrol capsule şeklinde güzüksün istiyorum kodu düzelt ayrıca koda viewBgSeparatöre - - - şeklinde görünsün istiyorum kodu düzelt.
import UIKit

class FlightCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    
       private var dashedLineLayer: CAShapeLayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        loadData()
        
        segmentedControl.selectedSegmentIndex = 0
        segmentValueChanged(segmentedControl)
       
        
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           setupSegmentedControlStyle()
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
        
        
        lblCityFrom.text = data.departureCity
        lblFromAirport.text = data.departureAirportCode
        
        lblCityTo.text = data.arrivalCity
        lblToAirport.text = data.arrivalAirportCode
        
        
        segmentedControl.layer.cornerRadius = 20
        segmentedControl.layer.masksToBounds = true
    }
    
    @IBAction func buttonChange(_ sender: Any) {
        if let flightData = viewModel.homeModel?.app.first?.data.first {
            lblCityFrom.text = flightData.arrivalCity
            lblFromAirport.text = flightData.arrivalAirportCode
            lblCityTo.text = flightData.departureCity
            lblToAirport.text = flightData.departureAirportCode
        }
    }
    
    @IBAction func buttonCalendar(_ sender: Any) {
        print("calendar")
    }
    
    @IBAction func buttonSearch(_ sender: Any) {
        let departureCity = lblCityFrom.text ?? ""
        let arrivalCity = lblCityTo.text ?? ""
        let departureDate = lblDepartureDate.text ?? ""
        
        guard let allFlights = viewModel.homeModel?.app.flatMap({ $0.data }) else { return }
        
        let searchResults = allFlights.filter {
            $0.departureCity == departureCity &&
            $0.arrivalCity == arrivalCity &&
            $0.departureTime?.contains(departureDate) == true
        }
    
    }
}

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
        return viewModel.homeModel?.app.flatMap({ $0.data }).count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlightHistoryCell", for: indexPath) as! FlightHistoryCell
        
        if let flightData = viewModel.homeModel?.app.flatMap({ $0.data })[indexPath.row] {
            cell.configure(with: flightData)
        }
        
        return cell
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            lblTitleDepartureDate.text = "Return Date"
            lblReturnDate.text = "12.12.24"
        case 1:
            lblTitleDepartureDate.text = ""
            lblReturnDate.text = "One Way"
        default:
            break
        }
    }
}

extension FlightCell {
   
    private func setupSegmentedControlStyle() {
        segmentedControl.layer.cornerRadius = segmentedControl.bounds.height / 2
        segmentedControl.layer.masksToBounds = true
        segmentedControl.clipsToBounds = true
    }

}
