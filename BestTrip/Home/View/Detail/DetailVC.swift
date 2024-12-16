//
//  DetailVC.swift
//  BestTrip
//
//  Created by IREM SEVER on 10.12.2024.
//

import UIKit

class DetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PassengerCellDelegate , CityCellDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = HomeViewModel()
    var detailType: DetailType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
        
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero
        collectionView.collectionViewLayout = layout
        registerCell()
    }
    
    func registerCell() {
        switch detailType {
        case .citySelection:
            collectionView.register(UINib(nibName: "CitySelection", bundle: nil), forCellWithReuseIdentifier: "CitySelection")
        case .dateSelection:
            collectionView.register(UINib(nibName: "DateSelectionCell", bundle: nil), forCellWithReuseIdentifier: "DateSelectionCell")
        case .passengerSelection:
            collectionView.register(UINib(nibName: "PassengerCell", bundle: nil), forCellWithReuseIdentifier: "PassengerCell")
        case .additionalServiceList:
            collectionView.register(UINib(nibName: "CampaignCell", bundle: nil), forCellWithReuseIdentifier: "CampaignCell")
        default:
            break
        }
    }
    
    func loadData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch detailType {
        case .citySelection, .dateSelection, .passengerSelection:
            return 1
        case .additionalServiceList:
            if let detailDataList = viewModel.homeModel?.app.first(where: { $0.type == .additionalService })?.data.first?.detailData {
                return detailDataList.count
            }
            return 1
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch detailType {
        case .citySelection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CitySelection", for: indexPath) as! CitySelection
            cell.delegate = self
            return cell
        case .dateSelection: 
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateSelectionCell", for: indexPath) as! DateSelectionCell
            
            return cell
        case .passengerSelection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PassengerCell", for: indexPath) as! PassengerCell
            cell.delegate = self
            return cell
        case .additionalServiceList:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
            if let detailDataList = viewModel.homeModel?.app.first(where: { $0.type == .additionalService })?.data.first?.detailData {
                let detailItem = detailDataList[indexPath.item]
                cell.configureDetail(with: detailItem)
            }
            return cell
        default:
            fatalError("")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch detailType {
        case .additionalServiceList:
            let width = collectionView.bounds.width - 20
            return CGSize(width: width, height: 180)
        case .passengerSelection:
            let width = collectionView.bounds.width - 20
            return CGSize(width: width, height: 700)
        default:
            let width = collectionView.bounds.width 
            let height: CGFloat = 720
            return CGSize(width: width, height: height)
        }
    }
    
    
    
    func didUpdatePassengerCount(adults: Int, children: Int, infant: Int) {
        print("Updated counts: Adults - \(adults), Children - \(children), Infants - \(infant)")
        
    }
    
    func didConfirmPassenger() {
        navigationController?.popViewController(animated: true)
    }
    
    func didSelectedCity() {
        navigationController?.popViewController(animated: true)
    }
    
}
