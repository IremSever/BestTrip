//
//  CitySelection.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//

import UIKit

protocol CityCellDelegate: Any {
    func didSelectedCity()
}

class CitySelection: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewSearchTo: UIView!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    var viewModel = HomeViewModel()
    private var searchBar: UISearchBar!
    private var isSearchingFrom = false
    private var isSearchingTo = false
    
    var delegate: CityCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        loadData()
        setupSearchBar()
        addSearchGesture()
    }
    
    func configure(with data: App) {
        if !isSearchingFrom && !isSearchingTo {
            lblTitle.text = " "
        } else {
            lblTitle.text = "All"
        }
    }
}

extension CitySelection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollectionView() {
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.showsVerticalScrollIndicator = false
        registerCell()
    }
    
    func registerCell() {
        collectionViewSearch.register(UINib(nibName: "CitiesCell", bundle: nil), forCellWithReuseIdentifier: "CitiesCell")
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionViewSearch.reloadData()
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeModel?.app.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.homeModel?.app[section].type
        
        if sectionType == .city {
            if isSearchingFrom || isSearchingTo {
                return viewModel.filteredCities.count
            } else {
                return viewModel.homeModel?.app[section].data.count ?? 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = viewModel.homeModel?.app[indexPath.section].type else {
            fatalError("Section type not found")
        }
        
        switch sectionType {
        case .campaign, .flights, .additionalService, .bestOppotunity:
            return UICollectionViewCell()
        case .city:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitiesCell", for: indexPath) as! CitiesCell
            let data: HomeData
            
            if isSearchingFrom || isSearchingTo {
                data = viewModel.filteredCities[indexPath.item]
                
            } else {
                data = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] ?? HomeData(title: "", titleImage: nil, detail: nil, image: nil, campaignDate: nil, validOfferDates: nil, validFlightDates: nil, offerEligibility: nil, validOfferRoutes: nil, fees: nil, numberOfSeats: nil, link: nil, flightNumber: nil, departureAirportName: nil, departureAirportCode: nil, arrivalAirportName: nil, arrivalAirportCode: nil, departureCity: nil, arrivalCity: nil, departureTime: nil, arrivalTime: nil, date: nil, price: nil, isDirect: nil, detailData: nil, city: "", country: "", airport: "")
            }
            
            cell.configure(with: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 48
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionType = viewModel.homeModel?.app[indexPath.section].type else {
            return
        }
        
        if sectionType == .city {
            let selectedCity: HomeData
            
            if isSearchingFrom || isSearchingTo {
                selectedCity = viewModel.filteredCities[indexPath.item]
            } else {
                selectedCity = viewModel.homeModel?.app[indexPath.section].data[indexPath.item] ?? HomeData(title: "", titleImage: nil, detail: nil, image: nil, campaignDate: nil, validOfferDates: nil, validFlightDates: nil, offerEligibility: nil, validOfferRoutes: nil, fees: nil, numberOfSeats: nil, link: nil, flightNumber: nil, departureAirportName: nil, departureAirportCode: nil, arrivalAirportName: nil, arrivalAirportCode: nil, departureCity: nil, arrivalCity: nil, departureTime: nil, arrivalTime: nil, date: nil, price: nil, isDirect: nil, detailData: nil, city: "", country: "", airport: "")
            }
            
            if isSearchingFrom {
                lblFrom.text = selectedCity.city
                isSearchingFrom = false
            } else if isSearchingTo {
                lblTo.text = selectedCity.city
                isSearchingTo = false
            }
            
            searchBar.resignFirstResponder()
            searchBar.isHidden = true
            collectionViewSearch.reloadData()
            
            if let fromText = lblFrom.text, !fromText.isEmpty,
               let toText = lblTo.text, !toText.isEmpty {
                delegate?.didSelectedCity()
            }
        }
    }
}

extension CitySelection: UISearchBarDelegate {
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Make a Selection"
        searchBar.isHidden = true
        self.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addSearchGesture() {
        let searchTapGesture = UITapGestureRecognizer(target: self, action: #selector(showSearchBarForFrom))
        viewSearch.addGestureRecognizer(searchTapGesture)
        let searchTapGestureTo = UITapGestureRecognizer(target: self, action: #selector(showSearchBarForTo))
        viewSearchTo.addGestureRecognizer(searchTapGestureTo)
    }
    
    @objc private func showSearchBarForFrom() {
        isSearchingFrom = true
        isSearchingTo = false
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
    }
    
    @objc private func showSearchBarForTo() {
        isSearchingTo = true
        isSearchingFrom = false
        searchBar.isHidden = false
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if isSearchingFrom {
            lblFrom.text = searchText
        } else if isSearchingTo {
            lblTo.text = searchText
        }

        searchBar.placeholder = searchText.isEmpty ? "Make a Selection" : nil

        if isSearchingFrom || isSearchingTo {
            viewModel.filteredCities = viewModel.homeModel?.app.flatMap { $0.data }.filter {
                $0.city?.lowercased().contains(searchText.lowercased()) ?? false
            } ?? []
        } else {
            viewModel.filteredCities = []
        }

        collectionViewSearch.reloadData()
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchingFrom = false
        isSearchingTo = false
        searchBar.text = ""
        lblFrom.text = ""
        lblTo.text = ""
        searchBar.resignFirstResponder()
        searchBar.isHidden = true
        collectionViewSearch.reloadData()
    }
}
